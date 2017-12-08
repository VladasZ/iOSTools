//
//  BannerAlertView.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

public class BannerAlertView : UIView {
    
    @IBOutlet private var messageLabel: UILabel!
    
    private static weak var currentBanner: BannerAlertView?
    private static weak var currentView: UIView?
    
    public static var color: UIColor = UIColor.white
    public static var textColor: UIColor = UIColor.black
    public static var font: UIFont = UIFont.systemFont(ofSize: 15)
    public static var height: CGFloat = 50
    public static var customise: ((BannerAlertView) -> ())?
    
    public static func show(_ message: String, inView view: UIView) {
        
        if let currentBanner = currentBanner, currentView === view {
            currentBanner.messageLabel.text = message
            return
        }
        
        guard let banner = UINib(nibName: "BannerAlertView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? BannerAlertView else {
            return
        }
        
        banner.backgroundColor = color
        banner.messageLabel.textColor = textColor
        banner.messageLabel.text = message
        
        customise?(banner)
        
        banner.frame = CGRect(x: 0,
                              y: -height,
                              width: view.frame.width,
                              height: height)
        
        view.addSubview(banner)
        currentBanner = banner
        currentView = view
        
        UIView.animate(withDuration: 0.211) {
            banner.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.width,
                                  height: height)
        }
    }
    
    public static func dismiss() {
        guard let banner = currentBanner, let view = currentView else { return }
        
        UIView.animate(withDuration: 0.211, animations: {
            banner.frame = CGRect(x: 0,
                                  y: -height,
                                  width: view.frame.width,
                                  height: height)
        }, completion: { _ in
            banner.removeFromSuperview()
            currentBanner = nil
            currentView = nil
        })
    }
}

#endif
