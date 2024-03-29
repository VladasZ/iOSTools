//
//  ScreenFieldsCheck.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 27/06/2019.
//  Copyright © 2019 VladasZ. All rights reserved.
//

import Foundation

public class ScreenFieldsCheck {
    
    private let fields: [FieldCheck]

    public init(_ fields: [FieldCheck]) {
        self.fields = fields
    }
    
    public func check() -> String? {
        for field in fields {
            if let error = field.check() {
                return  error
            }
        }
        return nil
    }
    
    public func check(_ field: NSObject) -> String? {
        guard let field = fields.first(where: {$0.field === field }) else {
            LogError("No such field registered")
            return nil
        }
        if let error = field.check() {
            return error
        }
        return nil
    }
}
