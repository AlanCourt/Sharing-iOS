//
//  PerfilController.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase

class PerfilController: UIViewController, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    @IBAction func editProfileButtonClick(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    

    @IBOutlet weak var conhecimentosCollecView: UICollectionView!
    @IBOutlet weak var linksCollecView: UICollectionView!
    
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    @IBOutlet weak var nomePerfil: UILabel!
    @IBOutlet weak var idadePerfil: UILabel!
    @IBOutlet weak var cidadePerfil: UILabel!
    
    @IBOutlet weak var sairBtn: UIButton!
    @IBOutlet weak var excluirContaBtn: UIButton!
    
    var user:[String:Any]!
    let databaseManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfileData()
    }
    
    func getUserProfileData() {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let url = "images/" + uid + ".jpg"
            let ref = self.databaseManager.getReferenceByUid(node: "usuario", uid: uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                self.user = snapshot.value as? NSDictionary as! [String : Any]
                let foto = self.user["foto"] as! String
                if !foto.isEmpty {
                    self.downloadImageToMemory(url: url)
                } else {
                    self.fillFields()
                }
            }) { (error) in
                self.showMessage(title: "Erro", message: error.localizedDescription)
            }
        }
    }
    
    func fillFields() {
        self.nomePerfil.text = (self.user["nomeCompleto"] as! String)
        self.cidadePerfil.text = (self.user["cidade"] as! String)
        self.idadePerfil.text = calcAgeByDateBirth()
    }
    
    func downloadImageToMemory(url:String) {
        let islandRef = Storage.storage().reference().child(url)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                self.showMessage(title: "Erro", message: error.localizedDescription)
            } else {
                self.fotoPerfil.image = UIImage(data: data!)
                self.fillFields()
            }
        }
    }
    
    func calcAgeByDateBirth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let birthday:Date = dateFormatter.date(from: self.user["dataNascimento"] as! String)!
        
        return String(birthday.age) + " anos"
    }
    
    @IBAction func logoutButtonClick(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.changeStoryboard(name: "Login")
        } catch let signOutError as NSError {
            self.showMessage(title: "Erro", message: signOutError.localizedDescription)
        }
    }
    
    @IBAction func deleteAccountButtonClick(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
               self.showMessage(title: "Erro", message: error.localizedDescription)
            } else {
                self.changeStoryboard(name: "Login")
            }
        }
    }
    
}
extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}
