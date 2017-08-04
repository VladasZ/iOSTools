//
//  UIView+Style.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit
import QuartzCore
import SwiftyTools

fileprivate func setupView(_ view: UIView, withStyle style: Style?) {
    
    guard let style = style else { Log.error(); return }
    
    if let color = style.color {
        view.backgroundColor = color
    }
    
    if style.isCircle {
        view.circle()
    }
    
    if let cornerRadius = style.cornerRadius {
        view.layer.cornerRadius = cornerRadius
    }
    
    if let borderWidth = style.borderWidth {
        view.layer.borderWidth = borderWidth
    }
    
    if let borderColor = style.borderColor {
        view.layer.borderColor = borderColor.cgColor
    }
    
    if let clipsToBounds = style.clipsToBounds {
        view.clipsToBounds = clipsToBounds
    }
    
    if let font = style.font {
        
        if let label = view as? UILabel {
            label.font = font
        }
        else if let textField = view as? UITextField {
            textField.font = font
        }
        else if let textView = view as? UITextView {
            textView.font = font
        }
        else if let button = view as? UIButton {
            button.titleLabel?.font = font
        }
    }
    
    if let textColor = style.textColor {
        
        if let label = view as? UILabel {
            label.textColor = textColor
        }
        else if let textField = view as? UITextField {
            textField.textColor = textColor
        }
        else if let textView = view as? UITextView {
            textView.textColor = textColor
        }
        else if let button = view as? UIButton {
            button.setTitleColor(textColor, for: .normal)
        }
    }
    
    if let placeholderColor = style.placeholderColor {
        
        if let textField = view as? UITextField {
            
            let placeholderText = textField.placeholder ?? ""
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                                 attributes: [NSForegroundColorAttributeName : placeholderColor])
        }
    }
    
    if let textAlignment = style.textAlignment {
        
        if let textField = view as? UITextField {
            
            textField.textAlignment = textAlignment
        }
        else if let label = view as? UILabel {
            
            label.textAlignment = textAlignment
        }
    }
    
    if let shadow = style.shadow {
        
        view.layer.shadowOffset  = shadow.offset
        view.layer.shadowRadius  = shadow.radius
        view.layer.shadowOpacity = Float(shadow.opacity)
    }
    
    if let customCode = style.customCode {
        
        customCode(view)
    }
}

public extension UIView {
    
    @IBInspectable var styleID: String {
        get { return "nil" }
        set { setStyleWithID(newValue) }
    }
    
    var style: Style? {
        get { return Style(id: "nil") }
        set { setupView(self, withStyle: newValue) }
    }
    
    fileprivate func setStyleWithID(_ id: String) {
        
        style = Style.styleWithID(id)
    }
}

public extension UITextField {
    
    @IBInspectable override var styleID: String {
        get { return "nil" }
        set { setStyleWithID(newValue) }
    }
}

public extension UITextView {
    
    @IBInspectable override var styleID: String {
        get { return "nil" }
        set { setStyleWithID(newValue) }
    }
}
