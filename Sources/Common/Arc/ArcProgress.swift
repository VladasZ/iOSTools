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
    
    private var backgroundArc: Arc = Arc()
    private var progressArc: Arc = Arc()
    
    public var center: CGPoint = CGPoint(100, 100) { didSet { setupArcs { $0.center = center } } }
    public var size:   CGSize  = CGSize(200, 200)  { didSet { setupArcs { $0.size   = size   } } }
    public var width:  CGFloat = 10                { didSet { setupArcs { $0.width  = width  } } }
    public var radius: CGFloat = 80                { didSet { setupArcs { $0.radius = radius } } }
    public var clockwise: Bool = true              { didSet { setupProgress() } }
    
    public var backgroundColor: UIColor?
    public var color: UIColor = UIColor.green
    
    public func setColorAndDimBackground(_ color: UIColor) {
        self.color = color
        self.backgroundColor = color.withAlphaComponent(0.3)
    }
    
    public init() { }
    
    public var progress: CGFloat = 0.5 { didSet { setupProgress() } }
    
    public var indicatorPosition: CGPoint { return CGPoint.onCircleWith(radius: radius - width / 2,
                                                                        angle: progressArc.endAngle,
                                                                        center: center) }
    
    public var position: ArcPosition = .full {
        didSet {
            backgroundArc.position = position
            progressArc.position = position
        }
    }
    
    private var angleSpan: CGFloat { return abs(backgroundArc.startAngle - backgroundArc.endAngle) }
    
    private func setupProgress() {
        if progress < 0 { progress += 1; return }
        if progress > 1 { progress -= 1; return }
        
        if clockwise {
            progressArc.endAngle = backgroundArc.endAngle - angleSpan * progress
        }
        else {
            progressArc.startAngle = backgroundArc.startAngle + angleSpan * progress
        }
    }
    
    private func setupArcs(_ setup: (Arc) -> ()) {
        setup(backgroundArc)
        setup(progressArc)
    }
    
    public func drawInContext(_ ctx: CGContext) {
        
        if let backColor = backgroundColor {
            if position == .full {
                ctx.setFillColor(backColor.cgColor)
                ctx.setStrokeColor(backColor.cgColor)
                ctx.addEllipse(in: CGRect(center: backgroundArc.center,
                                          size: backgroundArc.radius * 2 - width))
                ctx.setLineWidth(backgroundArc.width)
                ctx.strokePath()
            }
            else {
                backgroundArc.drawInContext(ctx, withColor: backColor)
            }
        }
        
        progressArc.drawInContext(ctx, withColor: color)
    }
}

