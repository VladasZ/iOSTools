//
//  UIViewTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/26/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

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
