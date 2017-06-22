//
//  UIColorTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(_ red:Int, _ green:Int, _ blue:Int, _ alpha:CGFloat) {
        
        self.init(red:   red.CGFloat   / 255.0,
                  green: green.CGFloat / 255.0,
                  blue:  blue.CGFloat  / 255.0,
                  alpha: alpha)
    }
    
    convenience init(_ red:Int, _ green:Int, _ blue:Int) {
        
        self.init(red, green, blue, 1)
    }
    
    static var random:UIColor {
        
        return UIColor(Int(arc4random_uniform(255)),
                       Int(arc4random_uniform(255)),
                       Int(arc4random_uniform(255)))
    }
}
