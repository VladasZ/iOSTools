//
//  TopPushPanel.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 8/14/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit
import SwiftyTools

open class TopPushPanel {
    
    //MARK: - Properties
    
    private static var isVisible: Bool = false
    public static var view: UIView!
    
    open class var height: CGFloat { Log.error(); return CGFloat() }
    
    open class var visibilityDuration: Int { return 2 }
    open class var animationDuration: TimeInterval { return 0.211 }
    open class var autoDismiss: Bool { return true }
    
    open class func setup() {
        
        view.frame = CGRect(x: 0, y: -height, width: keyWindow.width, height: height)
        keyWindow.addSubview(view)
    }
    
    public static func show() {
        
        if view == nil { setup() }
        if isVisible { return }; isVisible = true
        
        keyWindow.bringSubviewToFront(view)
        view.isHidden = false
        
        UIView.animate(withDuration: animationDuration) { view.y = 0 }

        if autoDismiss { after(visibilityDuration.Double) { dismiss() } }
    }
    
    public static func dismiss() {
        UIView.animate(withDuration: animationDuration, animations: { view.y = -height  }){ _ in
            view.isHidden = true
            isVisible = false
        }
    }
}

#endif
