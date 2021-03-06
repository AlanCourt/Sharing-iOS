//
//  LinksCellController.swift
//  SharingIOS
//
//  Created by iossenac on 09/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit

class LinksCellController: UICollectionViewCell {
    
    @IBOutlet weak var linkLabel: UILabel!
    
    var link: [String:Any]! {
        didSet {
            self.linkLabel.text = self.link["url"] as? String
        }
    }
    
}
