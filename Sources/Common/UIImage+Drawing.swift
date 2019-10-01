//
//  UIImage+Drawing.swift
//  watchTest WatchKit Extension
//
//  Created by Vladas Zakrevskis on 12/1/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools

public extension UIImage {
    
    static func draw(_ width: CGFloat, _ height: CGFloat, _ drawingBlock: (_ ctx: CGContext) -> ()) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width, height))
        guard let context = UIGraphicsGetCurrentContext() else { LogError(); return UIImage() }
        drawingBlock(context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { LogError(); return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    static func draw(_ size: CGSize, _ drawingBlock: (_ ctx: CGContext) -> ()) -> UIImage {
        return draw(size.width, size.height, drawingBlock)
    }
}
