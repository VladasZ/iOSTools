//
//  XibView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 12/27/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

fileprivate func viewWithSize<T: XibView>(_ size: CGSize) -> T{
    return T(frame: CGRect(0, 0, size.width, size.height))
}

open class XibView : UIView {
    
    open class var defaultSize: CGSize { return CGSize(width: 100, height: 100) }
    
    public class func fromNib() -> Self { return viewWithSize(defaultSize) }
    
    private static var identifier: String { return String(describing: self) }
    private var identifier: String { return type(of: self).identifier }
    
    //MARK: - Initialization
    
    public required override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview(loadFromXib())
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        addSubview(loadFromXib())
        setup()
    }
    
    private func loadFromXib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: identifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
    
    open func setup() {
        
    }
}
