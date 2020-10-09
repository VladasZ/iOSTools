//
//  Spinner.swift
//  Actors Pocket Guide
//
//  Created by Vladas Zakrevskis on 9/29/20.
//  Copyright © 2020 Atomichronica. All rights reserved.
//

import UIKit


class Spinner {
    
    typealias View = Weak<UIView>
    typealias Spin = Weak<UIActivityIndicatorView>
    
    private static var spinners = [View : Spin]()
    
    private static var make: UIActivityIndicatorView {
        UIActivityIndicatorView(frame: CGRect(0, 0, 20, 20))
    }
    
    static func showIn(_ view: UIView) {
        let spinner = make
        after(0.2) { [weak spinner] in spinner?.startAnimating() }
        layout(spinner, in: view)
        view.isUserInteractionEnabled = false
        spinners[View(view)] = Spin(spinner)
    }
    
    static func hideFrom(_ view: UIView) {
        guard let pair = findFor(view) else { LogError(); return }
        spinners.removeValue(forKey: pair.view)
        guard let spinner = pair.spin.value else { LogError(); return }
        spinner.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
    private static func findFor(_ view: UIView) -> (view: View, spin: Spin)? {
        for (v, spinner) in spinners {
            if (v == view) {
                return (v, spinner)
            }
        }
        return nil
    }
    
}

fileprivate extension Spinner {
    
    static func layout(_ spinner: UIActivityIndicatorView, in view: UIView) {
        
        if let scroll = view as? UIScrollView {
            layout(spinner, in: scroll)
            return
        }
        
        view.addSubview(spinner)
        spinner.centerVertically()
        spinner.placeR(28)
    }
    
    static func layout(_ spinner: UIActivityIndicatorView, in scroll: UIScrollView) {
        guard let superview = scroll.superview else { LogError(); return }
        superview.addSubview(spinner)
        spinner.centerHorizontally()
        spinner.y = scroll.y + 20
    }
    
}

