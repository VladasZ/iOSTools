//
//  NumbersCasting.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension Int {
    var CGFloat: CGFloat { return CoreGraphics.CGFloat(self) }
}

public extension Double {
    var CGFloat: CGFloat { return CoreGraphics.CGFloat(self) }
}

public extension CGFloat {
    var Double: Double   { return Swift.Double(self) }
    var Int: Int         { return Swift.Int(self) }
    var String: String   { return Swift.String(describing: self) }
}
