//
//  Alert.swift
//  SwiftTools
//
//  Created by Vladas Zakrevskis on 2/10/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(iOS)

import UIKit

public struct Alert {
    
    fileprivate static var currentAlert: UIAlertController?
    
    public static var cancelLabel: String = "Cancel"
    public static var agreeLabel:  String = "OK"
    public static var errorLabel:  String = "Error"
    
    public static func dismiss() {
        currentAlert?.dismiss()
        currentAlert = nil
    }
        
    public static func show(_ message: String, _ agreeAction: (() -> ())? = nil) {
        present { conf in
            conf.title = message
            conf.buttons.append(AlertButton(text: agreeLabel, action: agreeAction))
        }
    }
        
    public static func error(_ message:String, configuration: AlertConfigurationBlock = nil) {
        present { conf in
            conf.title = errorLabel
            conf.message = message
            conf.buttons.append(AlertButton(text: agreeLabel))
        }
    }
    
    public static func question(_ message: String,
                                agreeTitle: String,
                                declineTitle: String? = nil,
                                declineAction: (() -> ())? = nil,
                                action: @escaping () -> ()) {
        present { conf in
            conf.title = message
            conf.buttons.append(AlertButton(text: declineTitle ?? cancelLabel, isDestructive: true, action: declineAction))
            conf.buttons.append(AlertButton(text: agreeTitle, action: action))
        }
    }
    
    public static func textFieldWithTitle(_ title: String, agreeAction: ((String) -> ())?) {
        present { conf in
            conf.title = title
            conf.hasTextField = true
            conf.textFieldCompletion = agreeAction
        }
    }
    
    public static func present(_ conf: AlertConfigurationBlock) {
        guard let conf = conf else { return }
        let _conf = AlertConfiguration()
        conf(_conf)
        
        let alert = UIAlertController(title: _conf.title, message: _conf.message, preferredStyle: .alert)
        currentAlert = alert
        
        if _conf.hasTextField {
            alert.addTextField(configurationHandler: _conf.textFieldConfiguration)
            alert.addAction(UIAlertAction(title: cancelLabel, style: .destructive, handler: nil))
            alert.addAction(UIAlertAction(title: agreeLabel, style: .default, handler: { action in
                if let agreeAction = _conf.textFieldCompletion {
                    agreeAction(alert.textFields?.first?.text ?? "")
                }
            }))
        }
        else {
            _conf.buttons.forEach { alert.addAction($0.UIAlertAction) }
        }
        
        topmostController.present(alert)
    }
}

#endif

#if os(watchOS)
    
    import WatchKit
    
    public class Alert {
        
        public static func show(_ message: String) {
            let action = WKAlertAction(title: "OK", style: .default, handler: { })
            rootController.presentAlert(withTitle: message, message: nil, preferredStyle: .alert, actions: [action])
        }
    }

#endif
