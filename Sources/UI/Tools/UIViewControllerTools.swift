//
//  UIViewControllerTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/13/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func push(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func present(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
