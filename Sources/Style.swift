//
//  Style.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public class Style {
    
    public static var styles = [Style]()
    
    public static func styleWithID(_ id: String) -> Style? {
        
        return (styles.filter { $0.identifier == id }).first
    }
    
    public var identifier: String
    
    public var color: UIColor?
    public var isCircle = false
    public var cornerRadius: CGFloat?
    public var borderWidth: CGFloat?
    public var borderColor: UIColor?
    public var clipsToBounds: Bool?
    
    public init(id: String) {
        
        identifier = id
    }
}
