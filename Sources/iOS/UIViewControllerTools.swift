//
//  UIViewControllerTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/13/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UIViewController {
    
    func push(_ controller: UIViewController) {
        sync { self.navigationController?.pushViewController(controller, animated: true) }
    }
    
    func pop() {
        sync { self.navigationController?.popViewController(animated: true) }
    }
    
    func present(_ controller: UIViewController) {
        sync { self.present(controller, animated: true, completion: nil) }
    }
    
    func dismiss() {
        sync { self.dismiss(animated: true, completion: nil) }
    }
}

#endif
