//
//  System.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/26/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//


import Foundation
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
                Log(font)
            }
        }
    }
    
    public static var orientation: UIInterfaceOrientationMask = .portrait {
        didSet {
            UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
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
            ((try? device.lockForConfiguration()) != nil) else { LogError(); return }
        
        device.torchMode = on ? .on : .off
        device.unlockForConfiguration()
    }
    
    public static func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    public static func openURL(_ url: URL?) {
        guard let url = url else { LogError("No URL"); return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    public static func openURL(_ urlString: String?) {
        guard let urlString = urlString else { LogError("No URL string"); return }
        guard let url = URL(string: urlString) else { LogError("Invalid URL"); return }
        openURL(url)
    }
    
    public static func sendEmail(_ email: String?) {
        guard let email = email, email.isValidEmail
            else { LogError("Invalid email"); return  }
        guard MFMailComposeViewController.canSendMail()
            else { LogError("Mail services are not available"); return }

        let mailController = MFMailComposeViewController()
        
        mailController.setToRecipients([email])
        topmostController.present(mailController)
    }
    
    public static func call(_ phoneNumber: String?) {
        guard var number = phoneNumber else { LogError("No phone number"); return }
        number = number.replacingOccurrences(of: " ", with: "")
                       .replacingOccurrences(of: "-", with: "")
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else { LogError() }
    }
}

