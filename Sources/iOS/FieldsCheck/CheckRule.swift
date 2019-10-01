//
//  CheckRule.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 27/06/2019.
//  Copyright © 2019 VladasZ. All rights reserved.
//

import SwiftyTools

public enum RuleType {
    case isEmail
    case lessThan
    case moreThan
    case noSpaces
    case notEmpty
    case wasSelected
}

public class CheckRule {
    
    private let value: Int
    private let type: RuleType
    
    public init(_ type: RuleType, _ value: Int = 0) {
        self.type = type
        self.value = value
    }
    
    internal func checkField(_ field: NSObject) -> String? {
        
        if type == .wasSelected {
            
            guard let wasSelected = field.value(forKey: "wasSelected") as? Bool else {
                LogError()
                return "Failed to get selection status from deop down"
            }
            
            if wasSelected {
                return nil
            }
            
            return "must be selected"
        }
        
        guard let text = field.value(forKey: "text") as? String else {
            LogError()
            return "Failed to get text from field"
        }
        
        switch type {
        case .isEmail:
            if text.isValidEmail {
                return nil
            }
            return "must be a valid email address"
        case .lessThan:
            if text.count < value {
                return nil
            }
            return "must be less than \(value) characters long"
        case .moreThan:
            if text.count > value {
                return nil
            }
            return "must be more than \(value) characters long"
        case .noSpaces:
            if text.rangeOfCharacter(from: .whitespacesAndNewlines) != nil {
                return "must not contain whitespaces"
            }
            return nil
        case .notEmpty:
            if text.isEmpty {
                return "must not be empty"
            }
            return nil
        case .wasSelected:
            LogError()
            return "Invalid rule for text field"
        }
    }
    
}
