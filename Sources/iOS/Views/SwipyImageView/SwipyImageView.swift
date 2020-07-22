//
//  SwipyImageView.swift
//  SwipyImageView
//
//  Created by Vladas Zakrevskis on 2/13/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

public protocol SwipyImageViewDelegate : class {
    func swipyImageViewDidSelectImage(_ index: Int)
}

public class SwipyImageView : XibView, UIScrollViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var stackViewWidth: NSLayoutConstraint!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet var stackViewPosition: NSLayoutConstraint!
    
    //MARK: - Properties
    
    @IBInspectable public var selectedColor: UIColor! = UIColor.white
    @IBInspectable public var notSelectedColor: UIColor! = UIColor.gray
    
    @IBInspectable public var dotSpacing: CGFloat = 9
    @IBInspectable public var dotSize: CGFloat = 8
    
    @IBInspectable public var dotsPosition: CGFloat = 6 { didSet { stackViewPosition.constant = dotsPosition } }
    
    public var customWidth: CGFloat?
    public var margin: CGFloat = 10
    
    public var delegate: SwipyImageViewDelegate?
    public var dotsVisible: Bool = false { didSet { stackView.isHidden = !dotsVisible } }
        
//    public var contentMode: UIView.ContentMode
//        { didSet { imageViews.forEach { $0.contentMode = contentMode } } }
//    
    private var dots = [UIView]()
    
    private var expectedIndex:Int {
        get {
            return Int(scrollView.contentOffset.x / areaWidth)
        }
    }
    
    private var imageWidth: CGFloat {
        return customWidth ?? frame.size.width
    }
    
    private var areaWidth: CGFloat {
        var _width = imageWidth
        if customWidth != nil { _width += margin }
        return _width
    }
    
    public var imageViews = [UIImageView]()
    public var imagesCount: Int = 0 {
        didSet {
            
            scrollView.removeAllSubviews()
            
            scrollView.bounces                = customWidth != nil
            scrollView.isPagingEnabled        = customWidth == nil
            stackView.isHidden                = customWidth != nil
            
            if imagesCount == 0 { return }
    
            scrollView.contentSize = CGSize(width: areaWidth * CGFloat(imagesCount),
                                            height: 0)
            
            for i in 0...imagesCount - 1 {
                
                let dot = newDot
                
                stackView.addArrangedSubview(dot)
                dots.append(dot)
                
                let imageView = UIImageView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: imageWidth,
                                                          height: self.frame.size.height))
                
                imageView.contentMode = .scaleAspectFit
                imageView.frame.origin.x = areaWidth * CGFloat(i)
                imageViews.append(imageView)
                
                scrollView.addSubview(imageView)
            }
            
            dots.first!.backgroundColor = selectedColor
            
            stackViewWidth.constant = calculateStackWidth()
        }
    }
    
    public var images: [UIImage] = [] {
        didSet {
            imagesCount = images.count
            for i in 0...images.count - 1 {
                imageViews[i].image = images[i]
            }
        }
    }
    
    private func calculateStackWidth() -> CGFloat {
        
        let dotsSpacing = dotSpacing * CGFloat(imagesCount - 1)
        let dotsSize    = dotSize    * CGFloat(imagesCount)
        return dotsSpacing + dotsSize
    }
    
    private var newDot:UIView {
        
        let dot = UIView(frame: CGRect(x:0, y:0, width: dotSize, height: dotSize))
        dot.circle()
        dot.backgroundColor = notSelectedColor
        
        return dot
    }
    
    //MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if imagesCount == 0 { return }
        
        scrollView.frame = self.frame
        
        scrollView.contentSize = CGSize(width: areaWidth * CGFloat(imagesCount),
                                        height: 0)
        
        for i in 0...imagesCount - 1 {
            
            imageViews[i].frame = CGRect(x:areaWidth * CGFloat(i),
                                         y:0,
                                         width:imageWidth,
                                         height:self.frame.size.height)
        }
    }
    
    public func setIndex(_ index: Int, animated: Bool = true) {
        scrollView.setContentOffset(CGPoint(index.toCGFloat * areaWidth, 0), animated: animated)
    }
    
    //MARK: - UIScrollViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if customWidth != nil { return }
        dots.forEach { dot in dot.backgroundColor = notSelectedColor }
        dots[expectedIndex].backgroundColor = selectedColor
        delegate?.swipyImageViewDidSelectImage(expectedIndex)
    }
}
