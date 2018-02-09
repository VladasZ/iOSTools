//
//  HorisontalPanel.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 25/12/2017.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools

public protocol HorisontalPanelDelegate : class {
    func horisontalPanelDidSelectIndex(_ index: Int)
}

public class HorisontalPanel : UIView {
    
    public var delegate: HorisontalPanelDelegate?
    
    public var titles: [String] = [] { didSet { setup() } }
    public var margin: CGFloat = 10
    public var font: UIFont = UIFont.systemFont(ofSize: 15)
    public var color: UIColor = UIColor.gray
    public var selectedColor: UIColor = UIColor.black
    
    public var selectedIndex: Int = 0 { didSet { setupIndex() } }
    
    private var scrollView: UIScrollView!
    private var labels: [UILabel] = []
    
    private var lastX: CGFloat {
        if let label = labels.last { return label.maxX }
        return 0
    }
    
    private var contentWidth: CGFloat {
        var width: CGFloat = 0
        for title in titles {
            width += title.sizeFor(font: font).width
            width += margin
        }
        width -= margin
        return width
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    private func initialSetup() {
        scrollView = UIScrollView(frame: frame.withZeroOrigin)
        scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        setup()
        selectedIndex = 1
    }
    
    private func setup() {
        
        scrollView.removeAllSubviews()
        scrollView.contentSize = CGSize(contentWidth, height)
        
        if titles.count == 0 { return }

        for i in 0...titles.count - 1 {
            
            let title = titles[i]
            let label = UILabel(frame: CGRect(lastX,
                                              0,
                                              title.sizeFor(font: font).width + margin / 2,
                                              height))
            label.textAlignment = .center
            label.text = title
            label.font = font
            label.tag = i
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:))))
            label.textColor = color
            scrollView.addSubview(label)
            labels.append(label)
        }
    }
    
    private func setupIndex() {
        let index = selectedIndex
        labels.forEach { $0.textColor = self.color }
        labels[index].textColor = selectedColor
        delegate?.horisontalPanelDidSelectIndex(index)
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        selectedIndex = sender.view?.tag ?? 0
    }
}
