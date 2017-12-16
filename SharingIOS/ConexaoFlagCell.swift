//
//  ConexaoFlagCell.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit

class ConexaoFlagCell: UITableViewCell {
    
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var novaMensagem: UIButton!
    @IBOutlet weak var profissaoLabel: UILabel!
    
    var conexao: Conexao! {
        didSet {
            self.nomeLabel.text = self.conexao.nomeCompleto
            self.profissaoLabel.text = self.conexao.profissao
            //self.foto.image = UIImage(named: self.conexao.foto)
            //self.novaMensagem.image = UIImage(named: "icon-message")
            
        }
    }
}
