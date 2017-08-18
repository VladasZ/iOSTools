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
        
        var attributes = [String : Any]()
        
        if let font = font {
            attributes[NSFontAttributeName] = font
        }
        
        if let color = color {
            
            attributes[NSForegroundColorAttributeName] = color
        }
        
        if underlined {
            attributes[NSUnderlineStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue
        }
        
        if crossed {
            
            attributes[NSStrikethroughStyleAttributeName] = 2
        }
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
}
