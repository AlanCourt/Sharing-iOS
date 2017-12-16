//
//  User.swift
//  SharingIOS
//
//  Created by Tatiane Moreira on 14/12/2017.
//  Copyright © 2017 iossenac. All rights reserved.
//

import Foundation

class ModelFactory {
    
    static func getUser(nomeCompleto:String, dataNascimento:String, foto:String, cidade:String, ensina:String, sexo:String, profissao:String) -> [String: Any] {
        var data: [String: Any] = [
            "nomeCompleto": nomeCompleto,
            "dataNascimento": dataNascimento,
            "foto": foto,
            "cidade": cidade,
            "ensina": ensina,
            "sexo": sexo,
            "profissao": profissao
        ]
        return data
    }
    
    static func getLink(url:String, usuario:String) -> [String: Any] {
        var data: [String: Any] = [
            "url": url,
            "usuario": usuario
        ]
        return data
    }
    
    static func getKnowlege(titulo:String, nivel:String, usuario:String) -> [String: Any] {
        var data: [String: Any] = [
            "titulo": titulo,
            "nivel": nivel,
            "usuario": usuario
        ]
        return data
    }
}
