//
//  Style.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public struct Shadow {
    
    var offset: CGSize
    var radius: CGFloat
    var opacity: CGFloat
    
    init(offset: CGSize = CGSize.zero, radius: CGFloat = 0, opacity: CGFloat = 0) {
        
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
    }
}

public class Style {
    
    internal static var styles = [Style]()
    
    internal static func styleWithID(_ id: String) -> Style? {
        
        return (styles.filter { $0.identifier == id }).first
    }
    
    public var identifier:       String
    
    public var color:            UIColor?
    public var isCircle          = false
    public var cornerRadius:     CGFloat?
    public var borderWidth:      CGFloat?
    public var borderColor:      UIColor?
    public var clipsToBounds:    Bool?
    public var font:             UIFont?
    public var textColor:        UIColor?
    public var placeholderColor: UIColor?
    public var textAlignment:    NSTextAlignment?
    public var shadow:           Shadow?
    
    public init(id: String) {
        
        identifier = id
        Style.styles.append(self)
    }
}
