//
//  PerfilController.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit

class PerfilController: UIViewController, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
