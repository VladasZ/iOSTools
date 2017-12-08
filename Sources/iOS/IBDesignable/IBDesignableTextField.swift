//
//  IBDesignableTextField.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 8/18/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit
import SwiftyTools

@IBDesignable
open class IBDesignableTextField : UITextField {
    
    private var identifier: String { return String(describing: type(of: self)) }
    
    //MARK: - Initialization
    
    public override init(frame: CGRect) {
        
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

#endif
