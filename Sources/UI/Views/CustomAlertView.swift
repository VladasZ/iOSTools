//
//  CustomAlertView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/29/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import CustomIOSAlertView

open class CustomAlertView : UIView  {
    
    open class func getView() -> Self { return fromXib()! }
    open class var sideMargin: CGFloat { return 50 }
    
    open class var buttonTitles: [String]? { return nil }
    open class var buttonActions: ((CustomIOSAlertView?, Int32) -> ())? { return nil }
    
    private static var alert: CustomIOSAlertView!

    public class func show() {
        let view = self.getView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        alert = CustomIOSAlertView()!
        view.width = keyWindow.frame.size.width - sideMargin
        alert.buttonTitles = self.buttonTitles
        alert.containerView = view
        alert.onButtonTouchUpInside = self.buttonActions
        alert.show()
    }
    
    public func dismiss() {
        type(of: self).dismiss()
    }
    
    public class func dismiss() {
        alert?.close()
        alert = nil
    }
}
