//
//  AlertButton.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

public class AlertButton {
    
    public var text: String
    public var isDestructive: Bool
    public var action: (() -> ())?
    
    public var UIAlertAction: UIAlertAction {
        return UIKit.UIAlertAction(title: text, style: isDestructive ? .destructive : .default)
            { _ in sync { self.action?() } }
    }
    
    public init(text: String, isDestructive: Bool = false, action: (() -> ())? = nil) {
        self.text = text
        self.isDestructive = isDestructive
        self.action = action
    }
}

#endif
