//
//  DatabaseManager.swift
//  SharingIOS
//
//  Created by Tatiane Moreira on 09/12/2017.
//  Copyright © 2017 iossenac. All rights reserved.
//

/*
 EXEMPLOS DE UTILIZAÇÃO DOS MÉTODOS DA CLASSE
 
 let base:DatabaseManager = DatabaseManager()
 base.insert(node: "notificacao", data: ["nome":"teste", "recebe":false])
 base.update(node: "notificacao", childId: "-L-wTvQJ0SdKMMoAr98A", data: ["nome":"ok", "recebe":true])
 base.deleteById(node: "notificacao", childId: "-L-wTvQJ0SdKMMoAr98A")
 
 */

import Foundation
import Firebase

class DatabaseManager {
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func insert(node:String, data:[String:Any]) {
        ref.child(node).childByAutoId().setValue(data)
    }
    
    func update(node:String, childId:String, data:[String:Any]) {
        ref.child(node).child(childId).updateChildValues(data)
    }
    
    func deleteById(node:String, childId:String) {
        ref.child(node).child(childId).removeValue()
    }
    
    func searchEqual(node:String, filter:String, filterValue:Any) -> DatabaseQuery {
        return ref.child(node).queryOrdered(byChild: filter).queryEqual(toValue: filterValue)
    }
}

