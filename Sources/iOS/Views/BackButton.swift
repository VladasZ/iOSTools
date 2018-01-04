//
//  BackButton.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 1/4/18.
//  Copyright © 2018 Vladas Zakrevskis. All rights reserved.
//

import UIKit

open class BackButton : ExpandedHitAreaButton {
    
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
