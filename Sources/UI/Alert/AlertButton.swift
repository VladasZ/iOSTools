//
//  AlertButton.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public class AlertButton {
    
    var text: String
    var isDestructive: Bool
    var action: (() -> ())?
    
    var UIAlertAction: UIAlertAction {
        return UIKit.UIAlertAction(title: text, style: isDestructive ? .destructive : .default)
        { _ in self.action?() }
    }
    
    init(text: String, isDestructive: Bool = false, action: (() -> ())? = nil) {
        self.text = text
        self.isDestructive = isDestructive
        self.action = action
    }
}
