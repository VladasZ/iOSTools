//
//  AlertConfiguration.swift
//  iOSTools
//
//  Created by Vladas Zakrevskis on 11/22/17.
//  Copyright © 2017 VladasZ. All rights reserved.
//

#if os(iOS)

import UIKit

public typealias AlertConfigurationBlock = ((AlertConfiguration) -> ())?
public typealias AlertTextFieldConfigurationBlock = ((UITextField) -> Swift.Void)?

public class AlertConfiguration {
    public var title: String?
    public var message: String?
    public var buttons = [AlertButton]()
    public var hasTextField = false
    public var textFieldCompletion: ((String) -> ())?
    public var textFieldConfiguration: AlertTextFieldConfigurationBlock = nil
}

#endif
