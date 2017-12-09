//
//  ChatDataSource.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import ChattoAdditions
import Chatto

protocol AsyncDelegate{
    func done()
}

public protocol ChatItemProtocol: class {
    var uid: String { get }
    var type: ChatItemType { get }
}

public protocol ChatDataSourceProtocol: class {
    var hasMoreNext: Bool { get }
    var hasMorePrevious: Bool { get }
    var chatItems: [ChatItemProtocol] { get }
    weak var delegate: ChatDataSourceDelegateProtocol? { get set }
    
    func loadNext() // Should trigger chatDataSourceDidUpdate with UpdateType.Pagination
    func loadPrevious() // Should trigger chatDataSourceDidUpdate with UpdateType.Pagination
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion:(_ didAdjust: Bool) -> Void) // If you want, implement message count contention for performance, otherwise just call completion(false)
}

public protocol ChatDataSourceDelegateProtocol: class {
    func chatDataSourceDidUpdate(chatDataSource: ChatDataSourceProtocol, updateType: UpdateType)
}

class ChatDataSource: NSObject {
    //var data = [Filme]()
    var delegate: AsyncDelegate?
    
    public final func setChatDataSource(dataSource: ChatDataSourceProtocol?, triggeringUpdateType updateType: UpdateType?) {
        
    }
    
    override init() {
        super.init()
    }
    
}
        

