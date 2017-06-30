//
//  UIView+Style.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit
import SwiftyTools

public extension UIView {
    
    @IBInspectable var styleID: String {
        get { return "nil" }
        set { setStyleWithID(newValue) }
    }
    
    var style: Style? { get { return Style(id: "nil") }
        set {
            
            guard let style = newValue else { Log.error(); return }
            
            if let color = style.color {
                backgroundColor = color
            }
            
            if style.isCircle {
                circle()
            }
            
            if let cornerRadius = style.cornerRadius {
                layer.cornerRadius = cornerRadius
            }
            
            if let borderWidth = style.borderWidth {
                layer.borderWidth = borderWidth
            }
            
            if let borderColor = style.borderColor {
                layer.borderColor = borderColor.cgColor
            }
            
            if let clipsToBounds = style.clipsToBounds {
                self.clipsToBounds = clipsToBounds
            }
            
            if let font = style.font {
                
                if let label = self as? UILabel {
                    label.font = font
                }
                else if let textField = self as? UITextField {
                    textField.font = font
                }
                else if let textView = self as? UITextView {
                    textView.font = font
                }
                else if let button = self as? UIButton {
                    button.titleLabel?.font = font
                }
                else {
                    Log.error(style.identifier)
                }
            }
        }
    }
    
    private func setStyleWithID(_ id: String) {
        
        style = Style.styleWithID(id)
    }
}
