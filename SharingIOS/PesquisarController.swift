//
//  PesquisarController.swift
//  SharingIOS
//
//  Created by Alan Court on 14/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase

class PesquisarController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let databaseManager = DatabaseManager()
    
    var uid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let auth = Auth.auth().currentUser {
            self.uid = auth.uid
        }
        
    }
    
    /*func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.databaseManager.searchEqual(node: "usuario", filter: "ensina", filterValue: true)
        //return self.dataManager.movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pesquisarCell", for: indexPath) as! PesquisarCellController
        
        cell.movie = self.dataManager.movies[indexPath.row]
        
        return cell
        
    }
    
    func done() {
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
