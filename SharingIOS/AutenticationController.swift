//
//  AutenticationController.swift
//  SharingIOS
//
//  Created by Tatiane Moreira on 11/12/2017.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit

class AutenticationController : UIViewController {
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_ email : String) -> Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
}

extension UIViewController {
    func showMessage(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func changeStoryboard(name:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: name, bundle:nil)
        let mainViewController = storyBoard.instantiateInitialViewController()
        self.present(mainViewController!, animated:true, completion:nil)
    }
}
