//
//  TopPushPanel.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 8/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit
import SwiftyTools

public class TopPushPanel {
    
    //MARK: - Properties
    
    private static var isVisible: Bool = false
    public static var view: UIView!
    
    public class var height: CGFloat { Log.error(); return CGFloat() }
    
    public static var visibilityDuration: Int! = 2
    public static var animationDuration: TimeInterval = 0.211
    
    public class func setup() {
        
        view.frame = CGRect(x: 0, y: -height, width: keyWindow.width, height: height)
        keyWindow.addSubview(view)
    }
    
    public static func show() {
        
        if view == nil { setup() }
        if isVisible { return }; isVisible = true
        
        keyWindow.bringSubview(toFront: view)
        view.isHidden = false
        
        UIView.animate(withDuration: animationDuration) { view.y = 0 }

        if let visibilityDuration = visibilityDuration {
            after(visibilityDuration.Double) { dismiss() }
        }
    }
    
    public static func dismiss() {
        
        UIView.animate(withDuration: animationDuration, animations: { view.y = -height  }, completion: { _ in
            
            view.isHidden = true
            isVisible = false
        })
    }
}
