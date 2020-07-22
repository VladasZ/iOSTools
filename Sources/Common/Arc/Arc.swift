//
//  Arc.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 12/13/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

public enum ArcPosition {
    
    public static var quarterMargin: CGFloat = 0.0
    
    case top
    case bottom
    case left
    case right
    
    case topLeft
    case topRight
    case botLeft
    case botRight
    
    case full
    
    internal var points: (CGFloat, CGFloat) {
        switch self {
        case .top, .bottom: return (0, CGFloat.pi)
        case .left, .right: return (CGFloat.pi / 2, CGFloat.pi + CGFloat.pi / 2)
        case .topLeft:      return (CGFloat.pi + ArcPosition.quarterMargin, CGFloat.pi + CGFloat.pi / 2 - ArcPosition.quarterMargin)
        case .topRight:     return (CGFloat.pi + CGFloat.pi / 2 + ArcPosition.quarterMargin, CGFloat.pi * 2 - ArcPosition.quarterMargin)
        case .botLeft:      return (CGFloat.pi / 2 + ArcPosition.quarterMargin, CGFloat.pi - ArcPosition.quarterMargin)
        case .botRight:     return (0 + ArcPosition.quarterMargin, CGFloat.pi / 2 - ArcPosition.quarterMargin)
        case .full:         return (0 - CGFloat.pi / 2, CGFloat.pi * (3 / 2))
        }
    }
    
    internal var clockwise: Bool {
        switch self {
        case .full:   return true
        case .top:    return false
        case .bottom: return true
        case .left:   return true
        case .right:  return false
        case .topLeft, .topRight, .botLeft, .botRight: return true
        }
    }
}

public class Arc {
    
    public var center: CGPoint = CGPoint(100, 100)
    public var size:   CGSize  = CGSize(200, 200)
    public var width:  CGFloat = 10
    public var radius: CGFloat = 80
    
    public var startAngle: CGFloat = 0 - CGFloat.pi / 2 + 0.2
    public var endAngle:   CGFloat = CGFloat.pi + CGFloat.pi / 2 - 0.2
    
    public var clockwise: Bool = true
    
    public var position: ArcPosition? {
        didSet {
            if let position = position {
                startAngle = position.points.0
                endAngle = position.points.1
                clockwise = position.clockwise
            }
        }
    }
        
    private var innerRadius: CGFloat { return radius - width }
    
    public func createPath() -> UIBezierPath {
        
        let path = UIBezierPath()
        
        // Outer ArcProgress
        
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        
        // Left Cap
        
        path.addArc(withCenter: midpointForAngle(endAngle, center: center),
                    radius: width / 2,
                    startAngle: endAngle,
                    endAngle: endAngle - CGFloat.pi,
                    clockwise: clockwise)
        
        // Inner ArcProgress
        
        path.addArc(withCenter: center,
                    radius: innerRadius,
                    startAngle: endAngle,
                    endAngle: startAngle,
                    clockwise: !clockwise)
        
        // Right Cap
        
        path.addArc(withCenter: midpointForAngle(startAngle, center: center),
                    radius: width / 2,
                    startAngle: startAngle,
                    endAngle: startAngle - CGFloat.pi,
                    clockwise: !clockwise)
        
        return path
    }
    
    public func drawInContext(_ ctx: CGContext, withColor color: UIColor) {
        ctx.setFillColor(color.cgColor)
        ctx.addPath(createPath().cgPath)
        ctx.fillPath()
    }
    
    private func midpointForAngle(_ angle: CGFloat, center: CGPoint) -> CGPoint {
        let outer = CGPoint.onCircleWith(radius: radius, angle: angle, center: center)
        let inner = CGPoint.onCircleWith(radius: innerRadius, angle: angle, center: center)
        return outer.midPointWith(inner)
    }
}
