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
        }
    }
    
    func setStyleWithID(_ id: String) {
        
        style = Style.styleWithID(id)
    }
}
