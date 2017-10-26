//
//  SwipyImageView.swift
//  SwipyImageView
//
//  Created by Vladas Zakrevskis on 2/13/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

let DOTS_SPACING:CGFloat = 9
let DOT_SIZE:CGFloat = 8

public protocol SwipyImageViewDelegate : class {
    
    func swipyImageViewDidSelectImage(_ index: Int)
}

public class SwipyImageView : IBDesignableView, UIScrollViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet public var scrollView: UIScrollView!
    @IBOutlet public var stackViewWidth: NSLayoutConstraint!
    @IBOutlet public var stackView: UIStackView!
    
    //MARK: - Properties
    
    @IBInspectable public var selectedColor: UIColor! = UIColor.white
    @IBInspectable public var notSelectedColor: UIColor! = UIColor.gray
    
    public var delegate: SwipyImageViewDelegate?
    
    private var dots = [UIView]()
    public var imageViews = [UIImageView]()
    
    private var expectedIndex:Int {
        get {
            return Int(scrollView.contentOffset.x / frame.size.width)
        }
    }
    
    @IBInspectable public var imagesCount: Int = 0 {
        didSet {
            
            if imagesCount == 0 { return }
            
            scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(imagesCount), height: 0)
            
            for i in 0...imagesCount - 1 {
                
                let dot = newDot
                
                stackView.addArrangedSubview(dot)
                dots.append(dot)
                
                let imageView = UIImageView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: self.frame.size.width,
                                                          height: self.frame.size.height))
                
                imageView.contentMode = .scaleAspectFit
                imageView.frame.origin.x = self.frame.size.width * CGFloat(i)
                imageViews.append(imageView)
                
                scrollView.addSubview(imageView)
            }
            
            dots.first!.backgroundColor = selectedColor
            
            stackViewWidth.constant = calculateStackWidth()
        }
    }
    
    private func calculateStackWidth() -> CGFloat {
        
        let dotsSpacing = DOTS_SPACING * CGFloat(imagesCount - 1)
        let dotsSize    = DOT_SIZE     * CGFloat(imagesCount)
        return dotsSpacing + dotsSize
    }
    
    private var newDot:UIView {
        
        let dot = UIView(frame: CGRect(x:0, y:0, width: DOT_SIZE, height: DOT_SIZE))
        dot.circle()
        dot.backgroundColor = notSelectedColor
        
        return dot
    }
    
    //MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if imagesCount == 0 { return }
        
        scrollView.frame = self.frame
        
        scrollView.contentSize = CGSize(width: self.frame.size.width * CGFloat(imagesCount),
                                        height: 0)
        
        for i in 0...imagesCount - 1 {
            
            imageViews[i].frame = CGRect(x:self.frame.size.width * CGFloat(i),
                                         y:0,
                                         width:self.frame.size.width,
                                         height:self.frame.size.height)
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        dots.forEach { dot in dot.backgroundColor = notSelectedColor }
        dots[expectedIndex].backgroundColor = selectedColor
        delegate?.swipyImageViewDidSelectImage(expectedIndex)
    }
}
