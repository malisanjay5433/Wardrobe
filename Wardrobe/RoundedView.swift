//
//  RoundedView.swift
//  Wardrobe
//
//  Created by Sanjay Mali on 16/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    @IBInspectable
    var overridecornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }
        
        @IBInspectable
    var overrideborderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
        
        @IBInspectable
    var  overrideborderColor: UIColor? {
            get {
                if let color = layer.borderColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.borderColor = color.cgColor
                } else {
                    layer.borderColor = nil
                }
            }
        }
        
        @IBInspectable
    var overrideshadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.shadowRadius = newValue
            }
        }
        
        @IBInspectable
    var overrideshadowOpacity: Float {
            get {
                return layer.shadowOpacity
            }
            set {
                layer.shadowOpacity = newValue
            }
        }
        
        @IBInspectable
    var overrideshadowOffset: CGSize {
            get {
                return layer.shadowOffset
            }
            set {
                layer.shadowOffset = newValue
            }
        }
        
        @IBInspectable
        var overrideshadowColor: UIColor? {
            get {
                if let color = layer.shadowColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.shadowColor = color.cgColor
                } else {
                    layer.shadowColor = nil
                }
            }
        }
    }

