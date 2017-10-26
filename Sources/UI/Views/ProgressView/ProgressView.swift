//
//  ProgressView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/26/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public class ProgressView : IBDesignableView {
    
    @IBOutlet var progressView: UIView!
    @IBOutlet var progressViewVidth: NSLayoutConstraint!
    
    @IBInspectable public var progress: CGFloat = 0 { didSet { setupProgress() } }
    @IBInspectable public var cornerRadius: CGFloat = 0 { didSet { setupCornerRadius() } }
    @IBInspectable public var progressColor: UIColor! { didSet { setupProgressColor() } }
    @IBInspectable public var color: UIColor! { didSet { setupColor() } }

    func setupProgress() {
        progressViewVidth.constant = width * progress
        setNeedsLayout()
    }
    
    func setupProgressColor() {
        progressView.backgroundColor = progressColor
    }
    
    func setupColor() {
        subviews.first?.backgroundColor = color
    }
    
    func setupCornerRadius() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
