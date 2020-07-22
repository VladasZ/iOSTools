//
//  Defaults.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 8/3/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation

class _Defaults {
    
    private let defaults = UserDefaults.standard;

    fileprivate init() { }
    
    subscript<T>(key: String) -> T? {
        get {
            return defaults.value(forKey: key) as? T
        }
        set {
            defaults.set(newValue, forKey: key)
            defaults.synchronize()
        }
    }
    
}

let Defaults = _Defaults()
