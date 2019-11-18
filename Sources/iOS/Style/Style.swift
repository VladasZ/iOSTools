//
//  Style.swift
//  Actors Pocket Guide
//
//  Created by Vladas Zakrevskis on 03/06/2019.
//  Copyright © 2019 Atomichronica. All rights reserved.
//

import UIKit

public struct Shadow {
    
    public var offset: CGSize
    public var radius: CGFloat
    public var opacity: CGFloat
    
    public init(offset: CGSize = CGSize.zero, radius: CGFloat = 0, opacity: CGFloat = 0) {
        self.offset = offset
        self.radius = radius
        self.opacity = opacity
    }
}

public struct Style {
    
    internal static var styles = [Style]()
    
    internal static func styleWithID(_ id: String) -> Style? {
        return (styles.filter { $0.identifier == id }).first
    }
    
    public var identifier:               String
    
    public var color:                    UIColor?
    public var tintColor:                UIColor?
    public var isCircle                  = false
    public var cornerRadius:             CGFloat?
    public var borderWidth:              CGFloat?
    public var borderColor:              UIColor?
    public var clipsToBounds:            Bool?
    public var font:                     UIFont?
    public var textColor:                UIColor?
    public var placeholderColor:         UIColor?
    public var textAlignment:            NSTextAlignment?
    public var shadow:                   Shadow?
    public var isUserInteractionEnabled: Bool?
    public var customCode:       ((UIView) -> ())?
    
    init(id: String) {
        self.identifier = id
    }
    
    public static func create(id: String, _ initializer: ((inout Style) -> ())? = nil) {
        var style = Style(id: id);
        initializer?(&style)
        Style.styles.append(style)
    }
}
