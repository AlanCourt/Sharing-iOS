//
//  EsqueciSenhaController.swift
//  SharingIOS
//
//  Created by Tatiane Moreira on 14/12/2017.
//  Copyright © 2017 iossenac. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class EsqueciSenhaController : UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBAction func sendForgotPasswordButtonClick(_ sender: Any) {
        
        if let email = txtEmail.text, !email.isEmpty {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    self.showMessage(title: "Erro", message: error!.localizedDescription)
                } else {
                    self.showMessage(title: "", message: "Mensagem enviada com sucesso")
                }
            }
        } else {
            self.showMessage(title: "Atenção", message: "Informe o seu e-mail")
        }
    }
}
