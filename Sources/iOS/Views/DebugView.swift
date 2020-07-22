//
//  File.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 10/30/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

public typealias DebugButton = (String, () -> ())

fileprivate let wiewHeight:CGFloat = 100

public enum DebugViewPosition {
    
    case top
    case center
    case bottom
}

public class DebugView : UIView {
    
    //MARK: - Properties
    
    private static var instance: DebugView?
    private static var buttons: [DebugButton] = [DebugButton]()
    
    //MARK: - Interface
    
    public static var position: DebugViewPosition = .top { didSet { setupPosition() } }
    
    public static func addButton(_ title: String, _ action: @escaping () -> ()) {
        buttons.append((title, action))
        setupButtons()
    }
    
    public static func setButtons(_ buttons: [DebugButton]) {
        self.buttons = buttons
        setupButtons()
    }
    
    //MARK: - Setup
    
    private static func setupPosition() {
        
        if instance == nil { createView() }
        let view = instance!
        
        switch position {
        case .top: view.y = 0
        case .center: view.center = view.superview!.center
        case .bottom: view.y = keyWindow.height - wiewHeight
        }
    }
    
    private static func setupButtons() {
        if buttons.isEmpty { return }
        if instance == nil { createView() }
        let view = instance!
        
        view.removeAllSubviews()
        
        let buttonWidth = keyWindow.width / buttons.count.toCGFloat
        
        for i in 0...buttons.count - 1 {
            let button = UIButton(buttonWidth * i.toCGFloat, 0, buttonWidth, wiewHeight)
            button.setTitle(buttons[i].0, for: .normal)
            button.tag = i
            button.addTarget(view,
                             action: #selector(view.didPressButton(_:)),
                             for: .touchUpInside)
            button.backgroundColor = UIColor.random.withAlphaComponent(0.1)
            view.addSubview(button)
        }
    }
    
    private static func createView() {
        let window = keyWindow
        let view = DebugView(0, 0, window.width, wiewHeight)
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.8
        instance = view
        window.addSubview(view)
    }
    
    @objc private func didPressButton(_ sender: UIButton) {
        DebugView.buttons[sender.tag].1()
    }
}

#endif
