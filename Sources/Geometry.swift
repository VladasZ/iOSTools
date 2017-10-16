//
//  Geometry.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension CGPoint {
    
    init(_ x: CGFloat, _ y: CGFloat) {
        
        self.init(x:x, y:y)
    }
}

public extension CGSize {
    
    init(_ width: CGFloat, _ height: CGFloat) {
        
        self.init(width:width, height:height)
    }
}

public extension CGRect {
    
    var x: CGFloat {
        
        get { return origin.x }
        set { origin.x = newValue }
    }
    
    var y: CGFloat {
        
        get { return origin.y }
        set { origin.y = newValue }
    }
    
    var width: CGFloat {
        
        get { return size.width }
        set { size.width = newValue }
    }
    
    var height: CGFloat {
        
        get { return size.height }
        set { size.height = newValue }
    }
    
    var withZeroOrigin: CGRect {
        
        return CGRect(0, 0, width, height)
    }
    
    var center: CGPoint {
        
        return CGPoint(midX, midY)
    }
    
    init(width: CGFloat, height: CGFloat) {
        
        self.init(x:0, y:0, width:width, height:height)
    }
    
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        
        self.init(x:x, y:y, width:width, height:height)
    }
}
