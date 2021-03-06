//
//  UIImageTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 7/11/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit
import Kingfisher

public typealias UIImageCompletion  = (_ error: String?, _ image:   UIImage ) -> ()
public typealias UIImagesCompletion = (_ error: String?, _ images: [UIImage]) -> ()

public extension UIImage {
    
    static let dummy = UIImage()
    
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
        guard let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() else { LogError(); return self }
        UIGraphicsEndImageContext()
        return normalizedImage
    }
    
    func resize(targetSize: CGSize) -> UIImage {

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSize(size.width * widthRatio,  size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(0, 0, newSize.width, newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
    
    static func download(_ url: URLConvertible, _ completion: @escaping UIImageCompletion) {
        
        guard let url = url.toUrl else {
            completion("Invalid url", UIImage.dummy)
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value): completion(nil, value.image)
            case .failure(let error): completion(error.localizedDescription, UIImage.dummy)
            }
        }
        
    }
    
}

#endif
