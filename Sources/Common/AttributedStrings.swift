//
//  AttributedStrings.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 5/23/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension String {
    
    func attributed(font: UIFont? = nil, color: UIColor? = nil, underlined: Bool = false, crossed: Bool = false) -> NSMutableAttributedString {
        
        var attributes = [NSAttributedString.Key : Any]()
        
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        
        if let color = color {
            
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        
        if underlined {
            attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        if crossed {
            
            attributes[NSAttributedString.Key.strikethroughStyle] = 2
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
}
