//
//  FieldCheck.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 27/06/2019.
//  Copyright © 2019 VladasZ. All rights reserved.
//

import UIKit

public class FieldCheck {
    
    private var name: String
    var field: NSObject
    private var rules: [CheckRule]
    private var customError: String?
    
    public init(name: String, field: NSObject, rules: [CheckRule]) {
        self.name = name
        self.field = field
        self.rules = rules
    }
    
    func check() -> String? {
        for rule in rules {
            if let error = rule.checkField(field, with: name) {
                return error
            }
        }
        return nil
    }
        
}
