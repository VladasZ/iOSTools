//
//  UITableViewTools.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/3/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit
import SwiftyTools

public extension UITableView {
    
    func getCell<T: UITableViewCell>(_ type: T.Type, _ setup: ((T) -> ())? = nil) -> UITableViewCell {
        guard let cell: T = dequeueReusableCell(withIdentifier: T.identifier) as? T
            else { Log.error("No cell for identifier: \(T.identifier)"); return UITableViewCell() }
        setup?(cell)
        return cell
    }
}

public extension UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    
    class func registerFor(_ tableView: UITableView) {
        tableView.register(UINib(nibName: identifier, bundle: Bundle(for: self)), forCellReuseIdentifier: identifier)
    }
}

#endif
