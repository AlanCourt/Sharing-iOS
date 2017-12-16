//
//  ConexaoFlagCell.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase

class ConexaoFlagCell: UITableViewCell {
    
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var novaMensagem: UIButton!
    @IBOutlet weak var profissaoLabel: UILabel!
    
    var conexao: Conexao! {
        didSet {
            self.nomeLabel.text = self.conexao.nomeCompleto
            self.profissaoLabel.text = self.conexao.profissao
            downloadImageToMemory(url: conexao.foto)
            //self.novaMensagem.image = UIImage(named: "icon-message")
            
        }
    }
    
    func downloadImageToMemory(url:String) {
        let islandRef = Storage.storage().reference().child(url)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error == nil {
                self.foto.image = UIImage(data: data!)
            }
        }
    }
}
