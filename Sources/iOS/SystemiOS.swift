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
import MessageUI

public class System {
    
    public static func printFonts() {
        
//        for (NSString *family in [UIFont familyNames]) {
//
//            for(NSString *font in [UIFont fontNamesForFamilyName:family]) {
//                NSLog(@"\n%@", font);
//            }
//        }
        
        
        for family in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: family) {
                Log.info(font)
            }
        }
    }
    
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
    
    public static func openURL(_ url: URL?) {
        guard let url = url else { Log.error("No URL"); return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    public static func openURL(_ urlString: String?) {
        guard let urlString = urlString else { Log.error("No URL string"); return }
        guard let url = URL(string: urlString) else { Log.error("Invalid URL"); return }
        openURL(url)
    }
    
    public static func sendEmail(_ email: String?) {
        guard let email = email, email.isValidEmail
            else { Log.error("Invalid email"); return  }
        guard MFMailComposeViewController.canSendMail()
            else { Log.error("Mail services are not available"); return }

        let mailController = MFMailComposeViewController()
        
        mailController.setToRecipients([email])
        topmostController.present(mailController)
    }
    
    public static func call(_ phoneNumber: String?) {
        guard let number = phoneNumber else { Log.error("No phone number"); return }
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else { Log.error() }
    }
}

