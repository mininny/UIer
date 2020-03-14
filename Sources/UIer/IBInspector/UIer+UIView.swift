//
//  UIer+UIView.swift
//
//
//  Created by Minhyuk Kim on 2020/03/14.
//


import UIKit

public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat
    {
        set (radius) {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = radius > 0
        }
        
        get {
            return self.layer.cornerRadius
        }
    }

    
    @IBInspectable
    var borderWidth: CGFloat
    {
        set (width) {
            self.layer.borderWidth = width
        }
        
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor
    {
        set (color) {
            self.layer.borderColor = color.cgColor
        }
        
        get {
            guard let color = self.layer.borderColor else { return .black }
            return UIColor(cgColor: color)
        }
    }

    
    @IBInspectable
    var bgHexColor: String?
    {
        set (hexString) {
            guard let str = hexString else { return }
            self.backgroundColor = UIColor.hexStringToUIColor(hex: str)
        }
        
        get {
            return self.backgroundColor?.toHexString()
        }
    }
}
