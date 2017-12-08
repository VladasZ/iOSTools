//
//  SocialHelper.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 7/24/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

enum SocialNetwork {
    
    case facebook
    case instagram
    case linkedin
    case twitter
    case pinterest
    case youtube
}

class SocialHelper {
    
    static func openAccount(_ account: String, socialNetwork: SocialNetwork) {
        
        switch socialNetwork {
            
        case .facebook:  _openAccount(account, applicationURL: "fb://profile/", browserURL: "https://www.facebook.com/")
        case .instagram: _openAccount(account, applicationURL: "instagram://user?username=", browserURL: "https://www.instagram.com/")
        case .linkedin:  _openAccount(account, applicationURL: "linkedin://#profile/", browserURL: "https://www.linkedin.com/in/")
        case .twitter:   _openAccount(account, applicationURL: "twitter://user?id=", browserURL: "https://twitter.com/")
        case .pinterest: _openAccount(account, applicationURL: "pinterest://user/", browserURL: "http://www.pinterest.com/")
        case .youtube:   _openAccount(account, applicationURL: "youtube://www.youtube.com/channel/", browserURL: "http://www.pinterest.com/")
        }
    }
    
    private static func _openAccount(_ account: String, applicationURL: String, browserURL: String) {
        
        guard let url = URL(string: applicationURL + account) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            System.openURL(url)
            return
        }
        
        guard let browserURL = URL(string: browserURL + account) else {
            Alert.error("Wrong URL")
            return
        }
        
        System.openURL(browserURL)
    }
}

#endif
