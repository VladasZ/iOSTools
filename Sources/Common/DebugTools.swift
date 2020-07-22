//
//  Debug.swift
//  TransFix
//
//  Created by Vladas Zakrevskis on 3/29/17.
//  Copyright © 2017 VladasZ All rights reserved.
//


import UIKit

public extension Debug {
    
    static var notImplementedMessage = "Not implemented yet"
    
    static func notImplemented() {
        Alert.show(notImplementedMessage)
    }
    
    static func check(_ object: Any?, error: String) {
        if object == nil { LogError(error) }
    }
    
    static func checkForNil(_ object: Any?, error: String) {
        if object != nil { LogError(error) }
    }
    
    static func execute(_ block: () -> ()) {
        block()
    }
    
    static func executeOnSimulator(_ simulator: () -> (), device: () -> ()) {
        #if targetEnvironment(simulator)
            simulator()
        #else
            device()
        #endif
    }
    
    static func addressOf<T: AnyObject>(_ object: T) -> Int {
        return unsafeBitCast(object, to: Int.self)
    }
    
    //MARK: - Debug button
    
    #if os(iOS)
    
    private static var button: UIButton!
    private static var debugButtonAction: (() -> ())!
    
    static func onDebugButtonClick(_ action: @escaping () -> ()) {
        
        if button == nil {
            button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            button.addTarget(self, action: #selector(self.didPressDebugButton), for: .touchUpInside)
            button.backgroundColor = UIColor.gray
            button.alpha = 0.4
            keyWindow.addSubview(button)
        }
        
        debugButtonAction = action
    }
    
    @objc private static func didPressDebugButton() {
        debugButtonAction()
    }
    
    #endif

}


