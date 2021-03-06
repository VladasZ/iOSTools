//
//  Misc.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 12/8/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(watchOS)

import WatchKit

public var rootController: WKInterfaceController {
    
    guard let controller = WKExtension.shared().rootInterfaceController
        else { LogError(); return WKInterfaceController() }
    return controller
}

#endif
