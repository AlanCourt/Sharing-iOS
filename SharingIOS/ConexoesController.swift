//
//  ConexoesController.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ConexoesController: UIViewController {

    //var DatabaseReference = String("https://sharing-4e708.firebaseio.com/")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //print(ref)
        
        //TESTE DE LEITURA DO REALTIME DATABASE
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value as Any)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
