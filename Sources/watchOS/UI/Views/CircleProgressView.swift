//
//  CircleProgressView.swift
//  WatchTools WatchKit Extension
//
//  Created by Vladas Zakrevskis on 12/4/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(watchOS)

import WatchKit
import UIKit

class CircleProgressView {
    
    var value: CGFloat = 0.5 { didSet { setupValue() } }
    
    var radius: CGFloat {
        get { return arc.radius }
        set { arc.radius = newValue; setup() }
    }
    
    var width: CGFloat {
        get { return arc.width }
        set { arc.width = newValue; setup() }
    }

    private var imageView: WKInterfaceImage
    private let size = System.renderImageSize
    private var arc = Arc()
        
    init(imageView: WKInterfaceImage) {
        self.imageView = imageView
        setup()
    }

    func setup() {
        imageView.setImage(drawImage())
    }
    
    func setupValue() {
        if value > 1 { value -= 1; return }
        if value < 0 { value += 1; return }
        arc.endAngle = Arc.topPoint + CGFloat.pi * 2 * value
        imageView.setImage(drawImage())
    }
    
    private func drawImage() -> UIImage {
        return UIImage.draw(size.width, size.height) { ctx in
            
            let rect = CGRect(0, 0, size.width, size.height)
            
            ctx.draw(#imageLiteral(resourceName: "grad").cgImage!, in: rect)
            ctx.addPath(arc.path.cgPath)
            ctx.addRect(rect)
            ctx.setFillColor(UIColor.black.cgColor)
            ctx.drawPath(using: .eoFill)
            
            ctx.addEllipse(in: CGRect(center: arc.endCenter, width: 50, height: 50))
            ctx.setFillColor(UIColor.blue.cgColor)
            ctx.fillPath()
            
            ctx.addEllipse(in: CGRect(center: arc.endCenter, width: 45, height: 45))
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.fillPath()
        }
    }
}

#endif
