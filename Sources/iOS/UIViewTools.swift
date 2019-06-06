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
    
    @IBInspectable var cornerRadius: CGFloat {
        set { clipsToBounds = true; layer.cornerRadius = newValue }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { Log.warning(); return UIColor.clear }
    }
    
    var viewController: UIViewController? {
        var controller: UIResponder? = self.next
        while controller != nil {
            if let controller = controller as? UIViewController { return controller }
            controller = controller?.next
        }
        return nil
    }
    
    func flip() {
        layer.transform = CATransform3DConcat(layer.transform,
                                              CATransform3DMakeRotation(CGFloat.pi, 1.0, 0.0, 0.0))
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func addTransparentBlur(style: UIBlurEffect.Style = .light) {
        //http://stackoverflow.com/questions/17041669/creating-a-blurring-overlay-view
        if !UIAccessibility.isReduceTransparencyEnabled {
            backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            insertSubview(blurEffectView, at: 0)
        }
        else {
            Log.warning()
            backgroundColor = UIColor.clear
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
        return type(of: self).imageForXIB(name)
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
    
    func push(_ controller: UIViewController) {
        viewController?.push(controller)
    }
    
    func present(_ controller: UIViewController) {
        viewController?.present(controller)
    }
}

