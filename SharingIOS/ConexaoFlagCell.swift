//
//  ConexaoFlagCell.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit

class ConexaoFlagCell: UICollectionViewCell {
    
    
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var novaMensagem: UIImageView!
    
    var conexao: Conexao! {
        didSet {
            self.nomeLabel.text = self.conexao.nome
            self.foto.image = UIImage(named: self.conexao.foto)
            self.novaMensagem.image = UIImage(named: "icon-message")
            
        }
    }
}
