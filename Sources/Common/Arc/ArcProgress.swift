//
//  ArcProgress.swift
//  watchTest WatchKit Extension
//
//  Created by Vladas Zakrevskis on 11/30/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools





public class ArcProgress {
    
    private static let topPoint: CGFloat = 0 - CGFloat.pi / 2
    
    private var startAngle: CGFloat = ArcProgress.topPoint
    private var endAngle:   CGFloat = CGFloat.pi
    private var angleSpan: CGFloat { return maxAngle - minAngle }
    
    private var endCenter: CGPoint { return midpointForAngle(endAngle, center: center) }
    private var center: CGPoint { return renderSize.center }
    
    public var renderSize: CGSize = CGSize(200, 200)
    
    public var radius:   CGFloat = 90
    public var width:    CGFloat = 10
    
    public var minAngle: CGFloat = ArcProgress.topPoint
    public var maxAngle: CGFloat = CGFloat.pi
    
    public var value: CGFloat = 0.5 { didSet { setupValue() } }
    
    public var clockwise: Bool = true
    public var hasTipCap: Bool = false
    
    public var backgroundImage: UIImage?
    public var fillColor: UIColor = UIColor.blue
    public var backgroundColor: UIColor = UIColor.lightGray
    
    public var position: ArcPosition? {
        didSet {
            if let position = position {
                minAngle = position.points.0
                maxAngle = position.points.1
            }
        }
    }

    public init() { }
    
    public func drawImage() -> UIImage {
        return UIImage.draw(renderSize.width, renderSize.height) { ctx in
            self.drawInContextt(ctx)
        }
    }
    
    public func drawInContextt(_ ctx: CGContext) {
        
        let rect = CGRect(0, 0, renderSize.width, renderSize.height)
        
        if let image = self.backgroundImage {
            ctx.draw(image.cgImage!, in: rect)
            ctx.addRect(rect)
            ctx.setFillColor(UIColor.black.cgColor)
        }
        else {
            
            //ctx.addPath(backgroundPath.cgPath)
            ctx.setFillColor(backgroundColor.cgColor)
            ctx.fillPath()
            
            ctx.setFillColor(fillColor.cgColor)
        }
        
        //ctx.addPath(path.cgPath)
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

        Log.info("value: " + String(describing: value))

        startAngle = 0 + CGFloat.pi
        endAngle = CGFloat.pi
        
//        startAngle = maxAngle
//        endAngle = maxAngle + angleSpan * value
    
        Log.info("startAngle: " + String(describing: startAngle))
        Log.info("endAngle: " + String(describing: endAngle))
    }

    private func midpointForAngle(_ angle: CGFloat, center: CGPoint) -> CGPoint {
        return CGPoint()
    }
}
