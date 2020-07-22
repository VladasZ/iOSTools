//
//  CMTime.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 6/21/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import AVFoundation

fileprivate let hourMinTimeFormatter = DateFormatter("HH:mm")

public extension CMTime {
    
    public var toString: String {
        
        let date = Date(timeIntervalSinceReferenceDate: CMTimeGetSeconds(self))
        return hourMinTimeFormatter.string(from: date)
    }
    
}

#endif
