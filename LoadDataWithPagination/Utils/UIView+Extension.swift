//
//  UIView+Extension.swift
//  WeatherDemo
//
//  Created by JB on 4/7/24.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerrRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue
        }
    }
    
    
    @IBInspectable var borderWidth:CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            
            layer.borderWidth = newValue
            
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        get {
            guard let color = layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set {
            
            layer.borderColor = newValue?.cgColor
            
        }
    }
    
}
