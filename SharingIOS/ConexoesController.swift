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

class ConexoesController: UIViewController, UITableViewDelegate, UITableViewDataSource, FetchData {
    
    @IBOutlet weak var conexoesTable: UITableView!
    
    let databaseManager = DatabaseManager()
    var conexoes = [Conexao]()
    
    //@IBOutlet weak var collectionView: UICollectionView!
    //private var data: ConexaoDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseManager.delegate = self
        databaseManager.getConexoes()
        
        
        /*self.data = ConexaoDataSource()
        self.collectionView.dataSource = self
        let storage = Storage.storage()
        let storageRef = storage.reference()*/
        
    }
    
    func dataReceived(conexoes: [Conexao]) {
        self.conexoes = conexoes
        
        for conexao in conexoes {
            
            if conexao.id == Auth.auth().currentUser?.uid {
                //ConexaoDataSource.init().userName = conexao.nomeCompleto
            }
            
        }
        
        conexoesTable.reloadData()
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
