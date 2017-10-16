//
//  IBDesignableView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 7/7/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit
import SwiftyTools

fileprivate func viewWithSize<T>(_ size: CGSize) -> T where T: IBDesignableView {
    return T(frame: CGRect(0, 0, size.width, size.height))
}

@IBDesignable
open class IBDesignableView : UIView {
    
    public class var defaultSize: CGSize { return CGSize(width: 100, height: 100) }
    
    public class func fromNib() -> Self { return viewWithSize(defaultSize) }
    
    private static var identifier: String { return String(describing: self) }
    private var identifier: String { return type(of: self).identifier }
    
    //MARK: - Initialization
    
    public required override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview(loadFromXib())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        

        
        super.init(coder: aDecoder)
        addSubview(loadFromXib())
    }
    
    private func loadFromXib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: identifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setup()
        return view
    }
    
    open func setup() {
        
    }
}
