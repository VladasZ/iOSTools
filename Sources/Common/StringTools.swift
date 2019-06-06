//
//  StringTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 25/12/2017.
//  Copyright © 2017 Vladas Zakrevskis. All rights reserved.
//

import UIKit

public extension String {
    
    func sizeFor(font: UIFont) -> CGSize {
        let nsString = self as NSString
        return nsString.size(withAttributes:
            [NSAttributedString.Key.font: font])
    }
    
}
