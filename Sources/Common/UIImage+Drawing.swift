//
//  UIImage+Drawing.swift
//  watchTest WatchKit Extension
//
//  Created by Vladas Zakrevskis on 12/1/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools

extension UIImage {
    
    static func draw(_ width: CGFloat, _ height: CGFloat, _ drawingBlock: (_ ctx: CGContext) -> ()) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width, height))
        guard let context = UIGraphicsGetCurrentContext() else { Log.error(); return UIImage() }
        drawingBlock(context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { Log.error(); return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
