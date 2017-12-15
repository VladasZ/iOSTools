//
//  RoundButton.swift
//  swiftSand WatchKit Extension
//
//  Created by Vladas Zakrevskis on 12/8/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import WatchKit
import SwiftyTools

extension UIColor {
    
    static var buttonGray:  UIColor { return UIColor( 45,  45,  48) }
    static var buttonBlue:  UIColor { return UIColor(109, 174, 250) }
    static var buttonGreen: UIColor { return UIColor(  0, 226, 136) }
    static var buttonRed:   UIColor { return UIColor(245,   0,  63) }
}

class RoundButton {

    private let imageView: WKInterfaceObject
    
    var renderSize: CGFloat = 50
    var innerCircleRadius: CGFloat = 45
    var color: UIColor = UIColor.white { didSet { draw() } }
    var innerIndent: CGFloat { return renderSize - innerCircleRadius }
    var outerLineWidth: CGFloat = 2
    
    init(imageView: WKInterfaceObject) {
        self.imageView = imageView
        draw()
    }
    
    private func draw() {
        
        let image = UIImage.draw(renderSize, renderSize) { ctx in
            ctx.setFillColor(self.color.cgColor)
            ctx.setStrokeColor(self.color.cgColor)
            ctx.setLineWidth(2)
            ctx.addEllipse(in: CGRect(0 + innerIndent,
                                      0 + innerIndent,
                                      renderSize - innerIndent * 2,
                                      renderSize - innerIndent * 2))
            ctx.fillPath()
            ctx.addEllipse(in: CGRect(0 + outerLineWidth,
                                      0 + outerLineWidth,
                                      renderSize - outerLineWidth * 2,
                                      renderSize - outerLineWidth * 2))
            ctx.strokePath()
        }
        
        if let imageView = imageView as? WKInterfaceImage {
            imageView.setImage(image)
            return
        }
        
        if let button = imageView as? WKInterfaceButton {
            button.setBackgroundImage(image)
            return
        }
        
        Log.error()
    }
}
