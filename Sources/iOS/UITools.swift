//
//  UITools.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/16/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(iOS)

import UIKit

public var topmostController: UIViewController {
    
    var topController = UIApplication.shared.keyWindow?.rootViewController;
    
    while topController?.presentedViewController != nil {
        topController = topController?.presentedViewController;
    }
    
    guard let controller = topController
        else { LogError(); return UIViewController() }
    
    return controller
}

public var keyWindow: UIView {
    
    guard let _window = UIApplication.shared.delegate?.window,
        let window = _window
        else { LogError(); return UIView() }
    
    return window
}

func openSettings() {
    
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
        else { LogError(); return }
    
    System.openURL(settingsURL)
}

public extension UIView {
    
    //MARK: - Dummies
    
    static let dummyTag = "dummy".hash
    
    static var dummy: UIView {
        
        let dummy = UIView(CGRect(0, 0, 100, 100))
        dummy.backgroundColor = UIColor.random
        dummy.tag = dummyTag
        return dummy
    }
    
    func removeDummies() {
        
        for view in self.subviews {
            if view.tag == UIView.dummyTag {
                view.removeFromSuperview()
            }
        }
    }
    
    //MARK: - Initializators
    
    convenience init(_ frame: CGRect) {
        
        self.init(frame: frame)
    }
    
    convenience init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        
        self.init(frame:CGRect(x, y, width, height))
    }
    
    convenience init(width:CGFloat, height:CGFloat) {
        
        self.init(CGRect(0, 0, width, height))
    }
    
    //MARK: - Other
    
    @discardableResult func withColor(_ color:UIColor) -> Self {
        
        backgroundColor = color
        return self
    }
    
    @discardableResult func withColor(_ r:Int, _ g:Int, _ b:Int) -> Self {
        
        return self.withColor(UIColor(r, g, b))
    }
    
    @discardableResult func withFrame(_ frame:CGRect) -> Self {
        
        self.frame = frame
        return self
    }
    
    @discardableResult func withFrame(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) -> Self {
        
        return self.withFrame(CGRect(x, y, width, height))
    }
    
    @discardableResult func withSize(_ size: CGSize) -> Self {
        
        var frame = self.frame
        frame.size = size
        self.frame = frame
        return self
    }
    
    @discardableResult func withSize(_ width: CGFloat, _ height: CGFloat) -> Self {
        
        return self.withSize(CGSize(width: width, height: height))
    }
    
    @discardableResult func circle() -> Self {
        
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
        
        return self
    }
    
    func makeHoleAtCenterWithRadius(_ radius: CGFloat) {
        
        let holeFrame = CGRect(frame.size.width / 2 - radius,
                               frame.size.height / 2 - radius,
                               radius * 2,
                               radius * 2)
        
        makeHoleAt(holeFrame)
    }
    
    func makeHoleAt(_ rect: CGRect) {
        
        let backgroundPath = UIBezierPath(rect: CGRect(0, 0, frame.size.width, frame.size.height))
        let circlePath     = UIBezierPath(ovalIn: rect)
        
        circlePath.append(backgroundPath)
        
        let mask = CAShapeLayer()
        mask.path = circlePath.cgPath
        mask.fillRule = CAShapeLayerFillRule.evenOdd
        self.layer.mask = mask
    }
}

//MARK: - Animations

fileprivate let ANIMATION_DURATION:TimeInterval = 0.211

public extension UIView {
    
    func hideAnimated() {
        UIView.animate(withDuration: ANIMATION_DURATION,
                       animations: { self.alpha = 0},
                       completion: { _ in self.isHidden = true })
    }
    
    func showAnimated(_ show: Bool) {
        show ? showAnimated() : hideAnimated()
    }
    
    func showAnimated() {
        self.isHidden = false
        UIView.animate(withDuration: ANIMATION_DURATION) { self.alpha = 1 }
    }
    
    func setBackgroundColorAnimated(_ color:UIColor) {
        UIView.animate(withDuration: ANIMATION_DURATION) { self.backgroundColor = color }
    }
    
}

#endif
