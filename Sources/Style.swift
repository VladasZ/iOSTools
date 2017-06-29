//
//  Style.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

class Style {
    
    static var styles = [Style]()
    
    static func styleWithID(_ id: String) -> Style? {
        
        return (styles.filter { $0.identifier == id }).first
    }
    
    var identifier: String
    
    var color: UIColor?
    var isCircle = false
    var cornerRadius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: UIColor?
    var clipsToBounds: Bool?
    
    init(id: String) {
        
        identifier = id
    }
}
