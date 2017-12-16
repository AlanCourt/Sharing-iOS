//
//  ConhecimentosCellController.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit

class ConhecimentosCellController: UICollectionViewCell {
    
    @IBOutlet weak var tituloConhec: UILabel!
    @IBOutlet weak var nivelConhec: UILabel!
    
    @IBOutlet weak var likesConhec: UILabel!
    @IBOutlet weak var dislikesConhec: UILabel!
    
    var knowlege: [String:Any]! {
        didSet {
            self.tituloConhec.text = self.knowlege["titulo"] as? String
            self.nivelConhec.text = self.knowlege["nivel"] as? String
        }
    }
}
