//
//  IBDesignableView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 7/7/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit
import SwiftyTools

@IBDesignable
open class IBDesignableView : UIView {
    
    open var identifier: String {
        Log.error("To use IBDesignableView override identifier property" )
        return "IBDesignableView"
    }
    
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
