//
//  UIView+LazyProperties.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/25/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import UIKit

public extension UIView {
    
    //MARK: - Geometry
    
    var width: CGFloat {
        
        get { return self.frame.size.width }
        set {
            var frame = self.frame
            frame.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        
        get { return self.frame.size.height }
        set {
            var frame = self.frame
            frame.height = newValue
            self.frame = frame
        }
    }
    
    var x: CGFloat {
        
        get { return self.frame.origin.x }
        set {
            var frame = self.frame
            frame.x = newValue
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        
        get { return self.frame.origin.y }
        set {
            var frame = self.frame
            frame.y = newValue
            self.frame = frame
        }
    }
}
