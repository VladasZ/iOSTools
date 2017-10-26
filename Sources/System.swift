//
//  System.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/26/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

import Foundation
import SwiftyTools
import AudioToolbox
import AVFoundation

public class System {
    
    public static var flashIsOn: Bool {
        return AVCaptureDevice.default(for: AVMediaType.video)?.torchMode == .on
    }
    
    public static func turnFlashOn() {
        toggleFlash(on: true)
    }
    
    public static func turnFlashOff() {
        toggleFlash(on: false)
    }
    
    public static func toggleFlash(on: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video),
              device.hasTorch,
            ((try? device.lockForConfiguration()) != nil) else { Log.error(); return }
        
        device.torchMode = on ? .on : .off
        device.unlockForConfiguration()
    }
    
    public static func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
