//
//  AttributedStrings.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 5/23/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension String {
    
    public func attributed(font: UIFont? = nil, color: UIColor? = nil, underlined: Bool = false, crossed: Bool = false) -> NSMutableAttributedString {
        
        var attributes = [NSAttributedStringKey : Any]()
        
        if let font = font {
            attributes[NSAttributedStringKey.font] = font
        }
        
        if let color = color {
            
            attributes[NSAttributedStringKey.foregroundColor] = color
        }
        
        if underlined {
            attributes[NSAttributedStringKey.underlineStyle] = NSUnderlineStyle.styleSingle.rawValue
        }
        
        if crossed {
            
            attributes[NSAttributedStringKey.strikethroughStyle] = 2
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
}
