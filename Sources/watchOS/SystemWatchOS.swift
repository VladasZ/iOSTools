//
//  SystemWatchOS.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 12/8/17.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

#if os(watchOS)

import WatchKit

public enum WatchModel : CustomStringConvertible {
    
    case _38mm
    case _42mm
    
    public var description: String {
        switch self {
        case ._38mm: return "Apple Watch 38mm"
        case ._42mm: return "Apple Watch 42mm"
        }
    }
    
    public var statusBarHeight: CGFloat {
        switch self {
        case ._38mm: return 19
        case ._42mm: return 21
        }
    }
}

public extension CGSize {
    var pixels: CGSize { return CGSize(System.device.screenScale * System.screenSize.width,
                                       System.device.screenScale * System.screenSize.height) }
}

public class System {
    
    public static var device: WKInterfaceDevice { return WKInterfaceDevice.current() }
    
    public static var model: WatchModel { return screenSize.height == CGFloat(170.0) ? ._38mm : ._42mm }
    public static var screenSize: CGSize { return device.screenBounds.size }
    public static var controllerSize: CGSize { return CGSize(screenSize.width, screenSize.height - model.statusBarHeight) }
    public static var renderImageSize: CGSize { return CGSize(controllerSize.height, controllerSize.height).pixels }
    
}

#endif
