//
//  InsetLabel.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 8/1/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/3476646/uilabel-text-margin

@IBDesignable public class InsetLabel: UILabel {
    
    @IBInspectable public var topInset: CGFloat = 0.0
    @IBInspectable public var leftInset: CGFloat = 0.0
    @IBInspectable public var bottomInset: CGFloat = 0.0
    @IBInspectable public var rightInset: CGFloat = 0.0
    
    public var insets: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        
        return adjSize
    }
    
    public override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        
        return contentSize
    }
}
