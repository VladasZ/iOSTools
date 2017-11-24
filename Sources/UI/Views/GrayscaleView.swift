//
//  GrayscaleView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public class GrayscaleView : UIView {
    
    @IBInspectable public var isGray: Bool = false { didSet { setNeedsDisplay() } }
    
    override public func draw(_ rect: CGRect) {
        if !isGray { return }
        var context = UIGraphicsGetCurrentContext()!
        GrayscaleView.setGrayscale(context: &context, rect: rect)
    }
    
    class func setGrayscale( context: inout CGContext, rect: CGRect) {
        let originalImage: CGImage = context.makeImage()!
        let width: Int = originalImage.width
        let height: Int = originalImage.height
        let bytesPerComponent: Int = 8
        let bytesPerRow: Int = 0
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo: UInt32 = CGImageAlphaInfo.none.rawValue
        context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bytesPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)!
        let drawRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height))
        context.draw(originalImage, in: drawRect)
        let outputImage: UIImage = UIImage(cgImage: context.makeImage()!)
        outputImage.draw(in: rect)
    }
}
