//
//  ConhecimentoViewController.swift
//  SharingIOS
//
//  Created by Tatiane Moreira on 16/12/2017.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase

class ConhecimentoViewController: UIViewController {
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtLevel: UITextField!
    
    var knowlege:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
    }
    
    @IBAction func saveKnowlegeButtonClick(_ sender: Any) {
        if let title = txtTitle.text, let level = txtLevel.text, !title.isEmpty, !level.isEmpty {
            performSegue(withIdentifier: "salvarConhecimento", sender:nil)
        } else {
            showMessage(title: "Atenção", message: "Todos os campos são obrigatórios")
        }
    }
    
    @IBAction func cancelOperationButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "salvarConhecimento" {
            if let user = Auth.auth().currentUser {
                self.knowlege = ModelFactory.getKnowlege(titulo: txtTitle.text!, nivel: txtLevel.text!, usuario: user.uid)
            }
        }
    }
    
}
