//
//  LoginController.swift
//  SharingIOS
//
//  Created by iossenac on 25/11/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: AutenticationController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInButtonClick(_ sender: Any) {
        if let email = txtEmail.text, let password = txtPassword.text {
            if (email.isEmpty || password.isEmpty) {
                showMessage(title: "Atenção", message: "Todos os campos são obrigatórios!")
            } else {
                if (isEmailValid(email) ) {
                    if (isPasswordValid(password)) {
                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            if user != nil {
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                let mainViewController = storyBoard.instantiateInitialViewController()
                                self.present(mainViewController!, animated:true, completion:nil)
                            } else {
                                self.showMessage(title: "Erro", message: error.debugDescription)
                            }
                        }
                    } else {
                        showMessage(title: "Atenção", message: "A senha deve ter no mínimo 6 caracteres!")
                    }
                } else {
                    showMessage(title: "Atenção", message: "Email inválido!")
                }
            }
        }
    }
    
}

