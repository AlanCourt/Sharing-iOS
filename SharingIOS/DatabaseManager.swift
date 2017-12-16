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

protocol FetchData: class {
    func dataReceived(conexoes: [Conexao])
}

class DatabaseManager {
    var ref: DatabaseReference!
    
    weak var delegate: FetchData?
    
    init() {
        ref = Database.database().reference()
    }
    
    func insert(node:String, data:[String:Any]) {
        ref.child(node).childByAutoId().setValue(data)
    }
    
    func insert(node:String, uid:String, data:[String:Any]) {
        ref.child(node).child(uid).setValue(data)
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
    
    func getReferenceByUid(node:String, uid:String) -> DatabaseReference {
        return ref.child(node).child(uid)
    }
    
    func getReference(node:String) -> DatabaseReference {
        return ref.child(node)
    }
    
    /*func getConexoes() {
        
        ref.child("usuario").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var conexoes = [Conexao]()
            
            if let myConexoes = snapshot.value as? NSDictionary {
                for (key, value) in myConexoes {
                    if let conexaoData = value as? NSDictionary {
                        if let nome = conexaoData["nomeCompleto"] as? String {
                            let id = key as! String
                            let profissao = conexaoData["profissao"] as! String
                            let newConexao = Conexao(nomeCompleto: nome, foto:foto, id: id, profissao: profissao)
                            conexoes.append(newConexao)
                        }
                    }
                }
            }
            self.delegate?.dataReceived(conexoes: conexoes)
        })
    }*/
    
}

