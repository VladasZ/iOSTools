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
        draw()
    }
    
    private func draw() {
        imageView.setImage(UIImage.draw(200, 200) { ctx in
            
            self.arc.drawInContext(ctx)
            
        })
    }
    
}
