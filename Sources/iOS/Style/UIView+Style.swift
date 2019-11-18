//
//  UIView+Style.swift
//  Actors Pocket Guide
//
//  Created by Vladas Zakrevskis on 03/06/2019.
//  Copyright © 2019 Atomichronica. All rights reserved.
//

import UIKit
import QuartzCore

fileprivate func setupView(_ view: UIView, withStyle style: Style?) {
    
    guard let style = style else { print("Style is nil"); return }
    
    if let color = style.color {
        view.backgroundColor = color
    }
    
    if let tintColor = style.tintColor {
        view.tintColor = tintColor
    }
    
    if style.isCircle {
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.size.height / 2
    }
    
    if let cornerRadius = style.cornerRadius {
        view.clipsToBounds = true
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
                                                                 attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
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
    
    if let interactionEnabled = style.isUserInteractionEnabled {
        view.isUserInteractionEnabled = interactionEnabled
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

public extension UITextView {
    
    @IBInspectable override var styleID: String {
        get { return "nil" }
        set { setStyleWithID(newValue) }
    }
}
