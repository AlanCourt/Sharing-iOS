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

class ConexoesController: UIViewController,UICollectionViewDataSource {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var data: ConexaoDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = ConexaoDataSource()
        self.collectionView.dataSource = self
        let storage = Storage.storage()
        let storageRef = storage.reference()
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.data.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conexaoCell", for: indexPath) as! ConexaoFlagCell
        
        cell.conexao = self.data.data[indexPath.row]
        
        return cell
    }

    
    
    
}
