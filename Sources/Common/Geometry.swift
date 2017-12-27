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
    
    static func onCircleWith(radius: CGFloat, angle: CGFloat, center: CGPoint) -> CGPoint {
        return CGPoint(radius * cos(angle) + center.x, radius * sin(angle) + center.y)
    }
    
    func midPointWith(_ point: CGPoint) -> CGPoint {
        return CGPoint((x + point.x) / 2, (y + point.y) / 2)
    }
}

public extension CGSize {
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width:width, height:height)
    }
    
    var center: CGPoint { return CGPoint(width / 2, height / 2) }
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
    
    init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(center.x - width / 2, center.y - height / 2, width, height)
    }
    
    init(center: CGPoint, size: CGFloat) {
        self.init(center: center, width: size, height: size)
    }
}
