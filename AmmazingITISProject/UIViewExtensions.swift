//
//  UIViewExtensions.swift
//  Mobile-Mos.ru
//
//  Created by Ildar Zalyalov on 20.03.17.
//  Copyright © 2017 mos.ru. All rights reserved.
//

import UIKit


extension UIView {
    
    //MARK: - Размеры
    
    var size: CGSize {
        set (value) {self.frame.size = value}
        get         {return self.frame.size}
    }
    
    var width: CGFloat {
        set (value) {self.size = CGSize(width: value, height: frame.size.height)}
        get         {return self.frame.size.width}
    }
    
    var height: CGFloat {
        set (value) {self.size = CGSize(width: frame.size.width, height: value)}
        get         {return self.frame.size.height}
    }
    
    //MARK: - Положение
    
    var origin: CGPoint {
        set (value) {self.frame.origin = value}
        get         {return self.frame.origin}
    }
    
    var x: CGFloat {
        set (value) {self.origin = CGPoint(x: value, y: frame.origin.y)}
        get         {return self.frame.origin.x}
    }
    
    var y: CGFloat {
        set (value) {self.origin = CGPoint(x: frame.origin.x, y: value)}
        get         {return self.frame.origin.y}
    }
    
    //MARK: - Остальное
    
    func findAndResignFirstResponder () -> Bool {
        if self.isFirstResponder {
            self.resignFirstResponder()
            return true
        }
        
        for view in subviews {
            if view.findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
    
    var allSubviews: [UIView] {
        var arr:[UIView] = [self]
        
        for view in subviews {
            arr += view.allSubviews
        }
        
        return arr
    }
    
    override open var canBecomeFirstResponder: Bool {
        return true
    }
}

//MARK: - Extensions for Storyboard
public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set(newValue) { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    
    @IBInspectable var borderColor: UIColor {
        set(newValue) { self.layer.borderColor = newValue.cgColor }
        get { return UIColor(cgColor: self.layer.borderColor!) }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set(newValue) { self.layer.borderWidth = newValue }
        get { return self.layer.borderWidth }
    }
    
    @IBInspectable var shadowColor: UIColor {
        set(newValue) { self.layer.shadowColor = newValue.cgColor }
        get { return UIColor(cgColor: self.layer.shadowColor!) }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set(newValue) { self.layer.shadowOffset = newValue }
        get { return  self.layer.shadowOffset}
    }
    
    @IBInspectable var shadowOpacity: Float {
        set(newValue) { self.layer.shadowOpacity = newValue }
        get { return  self.layer.shadowOpacity}
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set(newValue) { self.layer.shadowRadius = newValue }
        get { return  self.layer.shadowRadius}
    }
    
    @IBInspectable var masksToBounds: Bool {
        set(newValue) { self.layer.masksToBounds = newValue }
        get { return self.layer.masksToBounds }
    }
    
}

extension UIProgressView {
    
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}
