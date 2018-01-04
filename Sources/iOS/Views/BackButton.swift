//
//  BackButton.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 1/4/18.
//  Copyright © 2018 Vladas Zakrevskis. All rights reserved.
//

import UIKit

open class BackButton : ExpandedHitAreaButton {
    
    private var _hitArea = CGSize(50, 50)
    
    @IBInspectable override open var hitArea: CGSize {
        get { return _hitArea }
        set { _hitArea = newValue }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
    }
    
    @objc private func didTap() {
        viewController?.pop()
    }
}
