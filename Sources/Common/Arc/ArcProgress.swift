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
    
    public var progress: CGFloat = 0.5 { didSet { setupProgress() } }
    
    public var position: ArcPosition? {
        didSet {
            if let position = position {
                backgroundArc.position = position
                progressArc.position = position
            }
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
            backgroundArc.drawInContext(ctx, withColor: backColor)
        }
        
        progressArc.drawInContext(ctx, withColor: color)
    }
}
