//
//  LinkButton.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 1/3/18.
//  Copyright © 2018 Vladas Zakrevskis. All rights reserved.
//

import UIKit

public class LinkButton : UIButton {
    
    @IBInspectable public var link: String?
    
    public override init(frame: CGRect) {
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
        guard let url = link?.toUrl else { LogError(); return }
        System.openURL(url)
    }
}
