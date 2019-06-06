//
//  LazyRecognizers.swift
//  SwiftLibs
//
//  Created by Vladas Zakrevskis on 5/15/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

fileprivate struct LazyRecognizer {
    
    weak var view: UIView?
    var action: () -> ()
}

fileprivate class LazyRecognizersManager {
    
    static var recognizers = [LazyRecognizer]()
    
    @objc static func handleTap(_ sender: UITapGestureRecognizer) {
        
        (recognizers.filter { $0.view == sender.view }).first?.action()
    }
}

public extension UIView {
    
    func onTap(_ action: @escaping () -> ()) {
        
        let recognizer = UITapGestureRecognizer(target: LazyRecognizersManager.self, action: #selector(LazyRecognizersManager.handleTap(_:)))
        
        addGestureRecognizer(recognizer)
        LazyRecognizersManager.recognizers.append(LazyRecognizer(view: self, action: action))
    }
}

#endif
