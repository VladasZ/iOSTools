//
//  UIViewTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/26/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit
import SwiftyTools

public extension UIView {
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addTransparentBlur(style: UIBlurEffectStyle = .light) {
        //http://stackoverflow.com/questions/17041669/creating-a-blurring-overlay-view
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.insertSubview(blurEffectView, at: 0)
        }
        else {
            Log.warning()
            self.backgroundColor = UIColor.clear
        }
    }
}

//MARK: - XIB images

public extension UIView {
    
    static func imageForXIB(_ name: String) -> UIImage? {
        let bundle = Bundle(for: self)
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    
    func imageForXIB(_ name: String) -> UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}

public extension UIView {
    
    class var className: String { return String(describing: self) }
    
    class func fromXib() -> Self? {
        return _fromXib()
    }
    
    private class func _fromXib<T: UIView>() -> T? {
        return UINib(nibName: className, bundle: Bundle(for: self)).instantiate(withOwner: nil, options: nil)[0] as? T
    }
}

#endif
