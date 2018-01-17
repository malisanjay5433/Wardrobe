//
//  PersistanceStore.swift
//  Wardrobe
//
//  Created by Sanjay Mali on 17/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import CoreData
class PersistanceService {
    private init(){
        
    }
    //    var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Wardrobe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func FetchDBUpperTable()->[DBUpperTable]{
        var post:[DBUpperTable]? = nil
        let fetchRequest:NSFetchRequest<DBUpperTable> = DBUpperTable.fetchRequest()
        do{
            post = try! PersistanceService.context.fetch(fetchRequest)
            return post!
        }catch{
            print("catch block")
            return post!
        }
    }
    
    class func FetchDBLowerTable()->[DBLowerTable]{
        var post:[DBLowerTable]? = nil
        
        let fetchRequest:NSFetchRequest<DBLowerTable> = DBLowerTable.fetchRequest()
        do{
            post = try! PersistanceService.context.fetch(fetchRequest)
            return post!
         }catch{
            print("catch block")
            return post!
        }
    }
    class func DeleteRecord(){
        let moc = PersistanceService.context
        let fetchRequest1:NSFetchRequest<DBUpperTable> = DBUpperTable.fetchRequest()
        let fetchRequest2:NSFetchRequest<DBLowerTable> = DBLowerTable.fetchRequest()

        let result1 = try? PersistanceService.context.fetch(fetchRequest1)
        let result2 = try? PersistanceService.context.fetch(fetchRequest2)
        
        for object in result1! {
            if object.upper_upperImage == nil {
                moc.delete(object)
            }
        }
        
        for object in result2! {
            if object.lowerImage == nil {
                moc.delete(object)
            }
        }
        
        do {
            try moc.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
        }
    }
    
}


