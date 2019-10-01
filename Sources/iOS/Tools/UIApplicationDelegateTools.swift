//
//  UIApplicationDelegateTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 2/13/18.
//  Copyright © 2018 Vladas Zakrevskis. All rights reserved.
//

import UIKit
import SwiftyTools

public extension UIApplicationDelegate {
    
    static func changeRootControllerAnimated(_ controller: UIViewController) {
        
        guard let _window = UIApplication.shared.delegate?.window else { LogError(); return }
        guard let window = _window else { LogError(); return }
        guard let snapshot = window.snapshotView(afterScreenUpdates: true) else { LogError(); return }
    
        controller.view.addSubview(snapshot);
        window.rootViewController = controller
        
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
    }
}
