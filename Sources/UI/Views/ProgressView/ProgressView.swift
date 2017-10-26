//
//  ProgressView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/26/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

enum ProgressViewOrientation : UInt {
    
    case horizontal = 0
    case vertical = 1
}

public class ProgressView : IBDesignableView {
    
    //MARK: - Outlets
    
    @IBOutlet var progressView: UIImageView!
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var progressViewWidth: NSLayoutConstraint!
    @IBOutlet var progressViewHeight: NSLayoutConstraint!

    //MARK: - Inspectables
    
    @IBInspectable public var progress: CGFloat = 0 { didSet { setupProgress() } }
    @IBInspectable public var cornerRadius: CGFloat = 0 { didSet { setupCornerRadius() } }
    @IBInspectable public var progressColor: UIColor! { didSet { setupProgressColor() } }
    @IBInspectable public var color: UIColor! { didSet { setupColor() } }
    @IBInspectable public var image: UIImage! { didSet { setupImage() } }
    @IBInspectable public var backgroundAlpha: CGFloat = 1 { didSet { setupBackgroundAlpha() } }
    @IBInspectable public var orientation: UInt = 0 { didSet { setupOrientation() } }

    //MARK: - Properties
    
    var _orientation: ProgressViewOrientation = .horizontal

    //MARK: - Setup
    
    public override func setup() {
        clipsToBounds = true
    }
    
    func setupOrientation() {
        _orientation = ProgressViewOrientation(rawValue: orientation)!
        setupProgress()
    }
    
    func setupBackgroundAlpha() {
        backgroundView.alpha = backgroundAlpha
    }
    
    func setupProgress() {
        
        if _orientation == .horizontal {
            progressViewWidth.constant = width * progress
            progressViewHeight.constant = height
        }
        else {
            progressViewWidth.constant = width
            progressViewHeight.constant = height * progress
        }
        
        setNeedsLayout()
    }
    
    func setupImage() {
        progressView.image = image
        backgroundView.image = image.monochrome
        color = UIColor.clear
        progressColor = UIColor.clear
    }
    
    func setupProgressColor() {
        progressView.backgroundColor = progressColor
    }
    
    func setupColor() {
        backgroundView.backgroundColor = color
    }
    
    func setupCornerRadius() {
        layer.cornerRadius = cornerRadius
    }
}
