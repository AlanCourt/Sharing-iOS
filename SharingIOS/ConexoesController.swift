//
//  ConexoesController.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ConexoesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var conexoesTable: UITableView!
    
    let databaseManager = DatabaseManager()
    var conexoes = [Conexao]()
    
    //@IBOutlet weak var collectionView: UICollectionView!
    //private var data: ConexaoDataSource!
    
    override func viewWillAppear(_ animated: Bool) {
        databaseManager.getReference(node: "usuario").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var conexoes = [Conexao]()
            
            if let myConexoes = snapshot.value as? NSDictionary {
                for (key, value) in myConexoes {
                    if let conexaoData = value as? NSDictionary {
                        if let nome = conexaoData["nomeCompleto"] as? String {
                            let id = key as! String
                            let profissao = conexaoData["profissao"] as! String
                            let foto = conexaoData["foto"] as! String
                            let newConexao = Conexao(nomeCompleto: nome, foto:foto, id: id, profissao: profissao)
                            conexoes.append(newConexao)
                        }
                    }
                }
            }
            self.conexoes = conexoes
            self.conexoesTable.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conexoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "conexaoCell", for: indexPath) as! ConexaoFlagCell
        
        cell.conexao = self.conexoes[indexPath.row]
        
        return cell
        
    }
    
    
    
    
    
    
    
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.data.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conexaoCell", for: indexPath) as! ConexaoFlagCell
        
        cell.conexao = self.data.data[indexPath.row]
        
        return cell
    }*/
    
}
