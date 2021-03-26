//
//  CheckRule.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 27/06/2019.
//  Copyright © 2019 VladasZ. All rights reserved.
//

import Foundation


public enum RuleType {
    case isEmail
    case lessThan
    case moreThan
    case noSpaces
    case notEmpty
    case notOnlySpaces
    case wasSelected
}

public class CheckRule {
    
    private let value: Int
    private let type: RuleType
    private let customError: String?
    
    private var name: String = ""
    
    public init(_ type: RuleType, _ value: Int = 0, customError: String? = nil) {
        self.type = type
        self.value = value
        self.customError = customError
    }
    
    internal func checkField(_ field: NSObject, with name: String) -> String? {
        self.name = name
        
        if type == .wasSelected {
            
            guard let wasSelected = field.value(forKey: "wasSelected") as? Bool else {
                LogError()
                return "Failed to get selection state from drop down"
            }
            
            return wasSelected ? nil : error(for: type)
        }
        
        guard let text = field.value(forKey: "text") as? String else {
            LogError()
            return "Failed to get text from field"
        }
        
        switch type {
        case .isEmail:
            return text.isValidEmail ? nil : error(for: type)
    
        case .lessThan:
            return text.count < value ? nil : error(for: type, value: value)
         
        case .moreThan:
            return text.count > value ? nil : error(for: type, value: value)
           
        case .noSpaces:
            return text.rangeOfCharacter(from: .whitespacesAndNewlines) != nil
            ? error(for: type) : nil
        
        case .notEmpty:
            return text.isEmpty ? error(for: type) : nil
            
        case .wasSelected:
            LogError()
            return "Invalid rule for text field"
            
        case .notOnlySpaces:
            return text.trim().count == 0 ? error(for: type) : nil
            
        }
    }
    
    internal func message(for type: RuleType, _ value: Int) -> String {
        switch type {
        case .isEmail:  return "must be a valid email address"
        case .lessThan: return "must be less than \(value) characters long"
        case .moreThan: return "must be more than \(value) characters long"
        case .noSpaces: return "must not contain whitespaces"
        case .notEmpty: return "must not be empty"
        case .notOnlySpaces: return "must not be empty"
        case .wasSelected:   return "must be selected"
        }
    }
    
    internal func error(for type: RuleType, value: Int = 0) -> String {
        guard customError == nil else { return customError.anyString }
        
        return name + " " + message(for: type, value)
    }
}
