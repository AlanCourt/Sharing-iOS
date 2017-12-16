//
//  LinkViewController.swift
//  SharingIOS
//
//  Created by Tatiane Moreira on 16/12/2017.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase

class LinkViewController: UIViewController {

    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var txtLink: UITextField!
    
    var link:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
    }
    
    @IBAction func saveLinkButtonClick(_ sender: Any) {
        if let link = txtLink.text, !link.isEmpty {
            performSegue(withIdentifier: "linkAddUnwind", sender: nil)
        } else {
            showMessage(title: "Atenção", message: "Todos os campos são obrigatórios")
        }
    }
    
    @IBAction func calcelLinkButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "linkAddUnwind" {
            if let user = Auth.auth().currentUser {
                self.link = ModelFactory.getLink(url: txtLink.text!, usuario: user.uid)
            }
        }
    }
    
}
