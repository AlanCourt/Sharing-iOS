//
//  MessagesHandler.swift
//  SharingIOS
//
//  Created by iossenac on 16/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import Foundation

class MessagesHandler {
    
    let databaseManager = DatabaseManager()
    
    private static let _instance = MessagesHandler()
    private init() {}
    
    static var Instance: MessagesHandler {
        return _instance
    }
    
    func sendMessage(senderId: String, senderName: String, text: String) {
        
        let data: Dictionary<String, Any> = ["sender_id": senderId, "sender_name": senderName, "text": text]
        
        databaseManager.insert(node: "mensagem", data: data)
    }
    
    
    
    
    
    
    
    
    
    
}
