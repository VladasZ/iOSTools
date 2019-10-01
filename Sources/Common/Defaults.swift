//
//  Defaults.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 8/3/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation
import SwiftyTools

fileprivate let defaults = UserDefaults.standard

public class Defaults {
    
    public static func setValue(_ value: Any?, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    public static func valueForKey<T>(_ key: String) -> T? {
        if let value = defaults.value(forKey: key) {
            if let tValue = value as? T { return tValue }
            LogError("Wrong defaults type for key: " + key)
            return nil
        }
        return nil
    }
}
