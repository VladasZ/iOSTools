//
//  Arc.swift
//  watchTest WatchKit Extension
//
//  Created by Vladas Zakrevskis on 11/30/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools

public class Arc {
    
    private static let topPoint: CGFloat = 0 - CGFloat.pi / 2
    
    private var innerRadius: CGFloat { return radius - width }
    private var startAngle: CGFloat = Arc.topPoint
    private var endAngle:   CGFloat = CGFloat.pi
    private var angleSpan: CGFloat { return maxAngle - minAngle }
    
    private var endCenter: CGPoint { return midpointForAngle(endAngle, center: center) }
    private var center: CGPoint { return renderSize.center }
    
    public var renderSize: CGSize = CGSize(200, 200)
    
    public var radius:   CGFloat = 90
    public var width:    CGFloat = 10
    public var minAngle: CGFloat = Arc.topPoint
    public var maxAngle: CGFloat = 0
    
    public var value: CGFloat = 0.5 { didSet { setupValue() } }
    
    public var clockwise: Bool = true
    public var hasTipCap: Bool = false
    
    public var backgroundImage: UIImage?
    public var fillColor: UIColor = UIColor.blue
    public var backgroundColor: UIColor = UIColor.lightGray

    public init() { }
    
    private func pathWithStartAngle(_ startAngle: CGFloat, _ endAngle: CGFloat) -> UIBezierPath {
        
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
    
    public var path: UIBezierPath { return pathWithStartAngle(startAngle, endAngle) }
    
    private var backgroundPath: UIBezierPath { return pathWithStartAngle(maxAngle, -minAngle) }
    
    public func drawImage() -> UIImage {
        return UIImage.draw(renderSize.width, renderSize.height) { ctx in
            self.drawInContext(ctx)
        }
    }
    
    public func drawInContext(_ ctx: CGContext) {
        
        let rect = CGRect(0, 0, renderSize.width, renderSize.height)
        
        if let image = self.backgroundImage {
            ctx.draw(image.cgImage!, in: rect)
            ctx.addRect(rect)
            ctx.setFillColor(UIColor.black.cgColor)
        }
        else {
            
            ctx.addPath(backgroundPath.cgPath)
            ctx.setFillColor(backgroundColor.cgColor)
            ctx.fillPath()
            
            ctx.setFillColor(fillColor.cgColor)
        }
        
        ctx.addPath(path.cgPath)
        ctx.drawPath(using: .eoFill)

        if (!self.hasTipCap) { return }
        
        ctx.addEllipse(in: CGRect(center: endCenter, width: 50, height: 50))
        ctx.setFillColor(UIColor.blue.cgColor)
        ctx.fillPath()
        
        ctx.addEllipse(in: CGRect(center: endCenter, width: 45, height: 45))
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillPath()
    }
    
    private func setupValue() {
        
        if value < 0 { value += 1; return }
        if value > 1 { value = value.truncatingRemainder(dividingBy: 1); return }

        Log.info(value)

        startAngle = maxAngle
        endAngle = maxAngle + angleSpan * value
    
        Log.info(startAngle)
        Log.info(endAngle)
    }

    private func midpointForAngle(_ angle: CGFloat, center: CGPoint) -> CGPoint {
        let outer = CGPoint.onCircleWith(radius: radius, angle: angle, center: center)
        let inner = CGPoint.onCircleWith(radius: innerRadius, angle: angle, center: center)
        return outer.midPointWith(inner)
    }
}
