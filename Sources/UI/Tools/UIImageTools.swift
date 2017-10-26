//
//  UIImageTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 7/11/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit
import SwiftyTools

public extension UIImage {
    
    var monochrome: UIImage {
        
        let context = CIContext(options: nil)
        
        let currentFilter = CIFilter(name: "CIPhotoEffectMono")
        currentFilter!.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgimg = context.createCGImage(output!,from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        
        return processedImage
    }
    
    var withoutRotation: UIImage {
        
        if imageOrientation == .up { return self }
        
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() else { Log.error(); return self }
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
