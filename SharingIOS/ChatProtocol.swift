//
//  ChatProtocol.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import Foundation
import UIKit
import ChattoAdditions


public protocol ChatInputItemProtocol: AnyObject {
    var tabView: UIView { get }
    var inputView: UIView? { get }
    var presentationMode: ChatInputItemPresentationMode { get }
    var showsSendButton: Bool { get }
    var selected: Bool { get set }
    
    func handleInput(input: AnyObject)
}
