//
//  WardrobeViewController.swift
//  Wardrobe
//
//  Created by Sanjay Mali on 17/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//
import UIKit
class WardrobeViewController: UIViewController{
    @IBOutlet  var collectionView1:UICollectionView!
    @IBOutlet  var collectionView2:UICollectionView!
    var flag = 0;
    var need_To_UpdateImage:UIImage?
    var picker = UIImagePickerController()
    var uppersImage = [DBUpperTable]()
    var lowersImage = [DBLowerTable]()
    @IBOutlet  var upperBtn:UIButton!
    @IBOutlet  var lowerBtn:UIButton!
    @IBOutlet  var favourite:UIButton!
    let coredata1 = DBUpperTable(context:PersistanceService.context)
    let coredata2 = DBLowerTable(context:PersistanceService.context)
    
    var istouch:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView1.delegate = self
        self.collectionView1.dataSource = self
        self.collectionView2.delegate = self
        self.collectionView2.dataSource = self
        self.picker.delegate = self
        self.fetchData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addPants(_ sender: Any) {
        flag  = 2
        showActionSheet()
        
    }
    @IBAction func addShirts(_ sender: Any) {
        flag = 1
        showActionSheet()
    }
    @IBAction func shuffle(_ sender: Any) {
        print("shuffle")
        
        print(uppersImage.count)
        print(lowersImage.count)
        if uppersImage.count == 1  && lowersImage.count == 1{
            showAlert(msg: "Model has no elements")
            return
        }
        _ = Int(arc4random_uniform(UInt32(uppersImage.count)))
        _ = Int(arc4random_uniform(UInt32(UInt16(lowersImage.count))))
        
        self.collectionView1.reloadData()
        self.collectionView2.reloadData()
        
    }
    @IBAction func favourite(_ sender: Any) {
        print("favourite")
        if istouch == true{
            istouch = false
            favourite.setImage(UIImage(named:"favorite"), for: .normal)
        }else{
            istouch = true
            favourite.setImage(UIImage(named:"like"), for: .normal)
            self.coredata1.upper_favouite = false
            self.coredata2.lower_favouite = false
        }
    }
    
    func camera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.delegate = self;
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }else{
            showAlert(msg:"No camera has found")
        }
    }
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            picker.delegate = self;
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }else{
            showAlert(msg:"Something went wrong while opening camera")
        }
    }
    func showActionSheet() {
        //        currentVC = vc
        let actionSheet = UIAlertController(title: "Upload Photos", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showAlert(msg:String) {
        let actionSheet = UIAlertController(title:msg, message: nil, preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction!) -> Void in
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension WardrobeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return uppersImage.count
            
        }
        else if collectionView.tag == 2{
            return lowersImage.count
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let image1  =  uppersImage[indexPath.row]

            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "wardrobeCell", for: indexPath) as! wardrobeCell
                        if image1.upper_upperImage == nil{
                            cell1.imageViewUpper.image = UIImage(named:"placeholder")
                        }
                        else{
            cell1.imageViewUpper.image = image1.upper_upperImage as? UIImage
                        }
            
            
            
            return cell1
        }
            
        else if collectionView.tag == 2{
            let image2  = lowersImage[indexPath.row]
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "wardrobePantCell", for: indexPath) as! wardrobePantCell
            
                        if image2.lowerImage == nil{
                            cell1.imageViewlower.image = UIImage(named:"placeholder")
            
                        }else{
            cell1.imageViewlower.image = image2.lowerImage as? UIImage
                        }
            return cell1
            
            
            
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width:collectionView.bounds.width,height:collectionView.bounds.height)
    }
}
extension WardrobeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // use the image
        let image: UIImage? = chosenImage
        if image == nil {
            return
        }
        if flag == 1{
            DispatchQueue.main.async {
                self.coredata1.upper_upperImage = chosenImage
                PersistanceService.saveContext()
                self.collectionView2.reloadData()
                
            }
        }
        else if flag == 2{
            DispatchQueue.main.async {
                print(chosenImage)
                self.coredata2.lowerImage = chosenImage
                PersistanceService.saveContext()
                self.collectionView2.reloadData()
            }
        }else{
            print("--------")
        }
        DispatchQueue.main.async {
            self.fetchData()
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func fetchData(){
        self.lowersImage = PersistanceService.FetchDBLowerTable()
        self.uppersImage = PersistanceService.FetchDBUpperTable()
        self.collectionView1.reloadData()
        self.collectionView2.reloadData()
        for i in lowersImage{
            print("Lower image1:\(String(describing: i.lowerImage))")
        }
        for i in uppersImage{
            print("upper image2:\(String(describing: i.upper_upperImage))")
            
        }
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension UIView {
    /// A property that accesses the backing layer's opacity.
    @IBInspectable
    open var opacity: Float {
        get {
            return layer.opacity
        }
        set(value) {
            layer.opacity = value
        }
    }
    
    /// A property that accesses the backing layer's shadow
    @IBInspectable
    open var shadowColor: UIColor? {
        get {
            guard let v = layer.shadowColor else {
                return nil
            }
            
            return UIColor(cgColor: v)
        }
        set(value) {
            layer.shadowColor = value?.cgColor
        }
    }
    
    /// A property that accesses the backing layer's shadowOffset.
    @IBInspectable
    open var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set(value) {
            layer.shadowOffset = value
        }
    }
    
    /// A property that accesses the backing layer's shadowOpacity.
    @IBInspectable
    open var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set(value) {
            layer.shadowOpacity = value
        }
    }
    
    /// A property that accesses the backing layer's shadowRadius.
    @IBInspectable
    open var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set(value) {
            layer.shadowRadius = value
        }
    }
    
    /// A property that accesses the backing layer's shadowPath.
    @IBInspectable
    open var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set(value) {
            layer.shadowPath = value
        }
    }
    
    
    /// A property that accesses the layer.cornerRadius.
    @IBInspectable
    open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set(value) {
            layer.cornerRadius = value
        }
    }
    
    
    /// A property that accesses the layer.borderWith.
    @IBInspectable
    open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(value) {
            layer.borderWidth = value
        }
    }
    
    /// A property that accesses the layer.borderColor property.
    @IBInspectable
    open var borderColor: UIColor? {
        get {
            guard let v = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: v)
        }
        set(value) {
            layer.borderColor = value?.cgColor
        }
    }
}
