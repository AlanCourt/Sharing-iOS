//
//  NewUserController.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewUserController: AutenticationController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var showProfileView:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.showProfileView
    }
    
    func saveNewUser(email:String, password:String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showMessage(title: "Erro", message: error.localizedDescription)
                return
            } else {
                self.showProfileView = true
                self.performSegue(withIdentifier: "createdUser", sender: nil)
            }
        }
    }

    @IBAction func creatAccountButtonClick(_ sender: Any) {
        if let email = txtEmail.text, let password = txtPassword.text, let confirmPassword = txtConfirmPassword.text {
            if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                showMessage(title: "Atenção", message: "Todos os campos são obrigatórios!")
            } else {
                if (isEmailValid(email)) {
                    if (isPasswordValid(password) && isPasswordValid(confirmPassword)) {
                        if password == confirmPassword {
                            saveNewUser(email: email, password: password)
                        } else {
                            showMessage(title: "Atenção", message: "As senhas informadas são diferentes!")
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