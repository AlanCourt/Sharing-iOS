//
//  CreateProfileController.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import DLRadioButton

class CreateProfileController: UIViewController {

    
    @IBOutlet weak var btnSexo: DLRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSexo.isMultipleSelectionEnabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSexoSelected(_ sender: DLRadioButton) {
        
        if sender.tag == 1 {
            print("Feminino")
        } else {
            print("Masculino")
        }
        
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
