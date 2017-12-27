//
//  CircleProgressView.swift
//  iOSTools WatchKit Extension
//
//  Created by Vladas Zakrevskis on 12/22/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import WatchKit


class CircleProgressView {
    
    var progress: CGFloat = 0          { didSet { update() } }
    var color: UIColor = UIColor.green { didSet { update() } }
    var backgroundColor: UIColor?      { didSet { update() } }
    var width: CGFloat = 10            { didSet { update() } }
    
    var hasIndicator: Bool = false
    
    private let imageView: WKInterfaceImage
    private let arc = ArcProgress()
    
    init(imageView: WKInterfaceImage) {
        self.imageView = imageView
        draw()
    }
    
    private func update() {
        arc.progress = progress
        arc.color = color
        arc.backgroundColor = backgroundColor
        arc.width = width
        draw()
    }
    
    private func draw() {
        imageView.setImage(UIImage.draw(200, 200) { ctx in
            arc.drawInContext(ctx)
            if hasIndicator { drawIndicator(ctx) }
        })
    }
    
    private func drawIndicator(_ ctx: CGContext) {
        
        let point = arc.indicatorPosition
        
        ctx.addEllipse(in: CGRect(center: point, size: 30))
        ctx.setFillColor(color.cgColor)
        ctx.fillPath()
        
        ctx.addEllipse(in: CGRect(center: point, size: 26))
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillPath()
    }
    
}
