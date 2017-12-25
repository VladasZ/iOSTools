//
//  MultiProgressControllerTools.swift
//  watchTest WatchKit Extension
//
//  Created by Vladas Zakrevskis on 11/29/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(watchOS)

import WatchKit

public extension WKInterfaceController {
    
    class var className: String { return String(describing: self) }
    
    func push<T: WKInterfaceController>(_ controller: T.Type) {
        pushController(withName: T.className, context: nil)
    }
}

#endif
