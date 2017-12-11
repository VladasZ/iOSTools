//
//  Arc.swift
//  watchTest WatchKit Extension
//
//  Created by Vladas Zakrevskis on 11/30/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(watchOS)

import WatchKit

public class Arc {
    
    public static let topPoint: CGFloat = 0 - CGFloat.pi / 2
    
    public var startAngle: CGFloat = Arc.topPoint
    public var endAngle:   CGFloat = CGFloat.pi
    public var radius:     CGFloat = 120
    public var width:      CGFloat = 10
    
    private var innerRadius: CGFloat { return radius - width }
    var endCenter: CGPoint { return midpointForAngle(endAngle, center: center) }
    
    public let center = System.controllerSize.pixels.center
    
    public var path: UIBezierPath {
        
        let path = UIBezierPath()
        
        // Outer Arc
        
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true)
        
        // Left Cap

        path.addArc(withCenter: midpointForAngle(endAngle, center: center),
                    radius: width / 2,
                    startAngle: endAngle,
                    endAngle: endAngle - CGFloat.pi,
                    clockwise: true)
        
        // Inner Arc
        
        path.addArc(withCenter: center,
                    radius: innerRadius,
                    startAngle: endAngle,
                    endAngle: startAngle,
                    clockwise: false)
        
        // Right Cap
        
        path.addArc(withCenter: midpointForAngle(startAngle, center: center),
                    radius: width / 2,
                    startAngle: startAngle,
                    endAngle: startAngle - CGFloat.pi,
                    clockwise: false)
                
        return path
    }

    private func midpointForAngle(_ angle: CGFloat, center: CGPoint) -> CGPoint {
        let outer = CGPoint.onCircleWith(radius: radius, angle: angle, center: center)
        let inner = CGPoint.onCircleWith(radius: innerRadius, angle: angle, center: center)
        return outer.midPointWith(inner)
    }
}

#endif
