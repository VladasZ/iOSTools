//
//  KeyboardAnimation.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 5/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

public class KeyboardAnimation {
    
    private static var height: CGFloat = 216
    private static var animationDuration: TimeInterval = 311
    private static var animationCurve: UIViewAnimationCurve! = nil
    private static var frame: CGRect?
    
    public static var scrollView: UIScrollView? = nil
    public static var spaceBelow: CGFloat = 100
    
    public static func initialize () {
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(KeyboardAnimation.keyboardWillHide(notification:)),
                         name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(KeyboardAnimation.keyboardWillShow(notification:)),
                         name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    public static func textFieldDidBeginEditing(_ textField: UITextField) {
        
        frame = textField.frame
    }
    
    @objc private class func keyboardWillHide(notification: NSNotification) {
        
        if scrollView == nil { return }
        
        let point = CGPoint(x:0, y:0)
        
        let animationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let animationCurve = UIViewAnimationCurve(rawValue: (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue)!
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        self.scrollView?.contentOffset = point
        
        UIView.commitAnimations()
    }
    
    @objc private class func keyboardWillShow(notification: NSNotification) {
        
        if scrollView == nil { return }
        
        var offset = KeyboardAnimation.height
        
        if let frame = self.frame {
            
            offset -= (scrollView!.frame.size.height - frame.maxY)
            offset += spaceBelow
        }
        
        if offset < 0 { return }
        
        let point = CGPoint(x:0, y:offset)
        
        let animationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let animationCurve = UIViewAnimationCurve(rawValue: (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue)!
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve)
        UIView.setAnimationBeginsFromCurrentState(true)
        
        scrollView?.contentOffset = point
        
        UIView.commitAnimations()
    }
}

#endif
