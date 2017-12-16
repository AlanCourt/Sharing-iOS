//
//  CreateProfileController.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import DLRadioButton
import MobileCoreServices
import Firebase


class CreateProfileController: UIViewController, UICollectionViewDataSource  {

    @IBOutlet weak var linkCollectionView: UICollectionView!
    @IBOutlet weak var knowlegeCollectionView: UICollectionView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var btnSexo: DLRadioButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtProfession: UITextField!
    
    private let datePicker = UIDatePicker()
    var imageData:Data!
    var showMainView:Bool = false
    var sexOption:String = "M"
    var teacher:String = "N"
    var uid:String!
    
    var link:[String:Any]!
    var links: [[String:Any]] = []
    var knowleges: [[String:Any]] = []
    var knowlege:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        self.linkCollectionView.dataSource = self
        //self.knowlegeCollectionView.dataSource = self
        btnSexo.isMultipleSelectionEnabled = false
        if let auth = Auth.auth().currentUser {
            self.uid = auth.uid
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "popupConhecimento" || identifier == "popupLink" {
            return true
        } else {
            return self.showMainView
        }
    }
    
    @IBAction func btnChoosePhotoClick(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        present(imagePicker, animated:true, completion:nil)
    }
    
    @IBAction func btnSexoSelected(_ sender: DLRadioButton) {
        switch sender.tag {
        case 1:
            self.sexOption = "F"
        case 2:
            self.sexOption = "M"
        case 3:
            self.teacher = "S"
        default:
            self.teacher = "N"
        }
    }
    
    func showDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: "doneDatePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: "cancelDatePicker")
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtBirthDate.inputAccessoryView = toolbar
        txtBirthDate.inputView = datePicker
    }
    
    func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtBirthDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func cancelDatePicker() {
        self.view.endEditing(true)
    }

    @IBAction func btnSaveProfileClick(_ sender: Any) {
        if let name = txtName.text, let birthDate = txtBirthDate.text, let city = txtCity.text, let profession = txtProfession.text, !name.isEmpty, !birthDate.isEmpty, !city.isEmpty, !profession.isEmpty {
            var user = ModelFactory.getUser(nomeCompleto: name, dataNascimento: birthDate, foto: "", cidade: city, ensina: teacher, sexo: sexOption, profissao: profession)
            if imgProfile.image != nil {
                uploadImageToFirebaseStorage(user)
            } else {
                saveNewUser(user)
            }
        } else {
            self.showMessage(title: "Atenção", message: "O nome, a data de nascimento e a cidade são obrigatórios")
        }
    }
    
    func saveNewUser(_ user:[String:Any]) {
        let databaseManager = DatabaseManager()
        databaseManager.insert(node: "usuario", uid: self.uid, data: user)
        for var i in (0..<links.count)
        {
            databaseManager.insert(node: "link", data: links[i])
        }
        self.changeStoryboard(name: "Main")
    }
    
    @IBAction func knowlegeAddButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "conhecimentoPopup", sender: nil)
    }
    
    @IBAction func linkAddButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "linkPopup", sender: nil)
    }
    
    @IBAction func knowlegeAddUnwind(segue: UIStoryboardSegue) {
        if let knowlegeVC = segue.source as? ConhecimentoViewController, segue.identifier == "knowlegeAddUnwind" {
            self.knowleges.append(knowlegeVC.knowlege)
            linkCollectionView.reloadData()
        }
    }
    
    @IBAction func linkAddUnwind(segue: UIStoryboardSegue) {
        if let linkVC = segue.source as? LinkViewController, segue.identifier == "linkAddUnwind" {
            self.links.append(linkVC.link)
            linkCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkMeuPerfil", for: indexPath) as! LinksCellController
        cell.link = self.links[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.links.count
    }
}

extension CreateProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let mediaType:String = info[UIImagePickerControllerMediaType] as? String else {
            dismiss(animated: true, completion: nil)
            return
        }
        if mediaType == (kUTTypeImage as String) {
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imgProfile.image = originalImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToFirebaseStorage(_ user:[String:Any]) {
        let storageRef = Storage.storage().reference()
        let urlImage = "images/" + self.uid + ".jpg"
        let mountainsRef = storageRef.child(urlImage)
        
        mountainsRef.putData(UIImagePNGRepresentation(imgProfile.image!)!, metadata: nil) { metadata, error in
            if (error != nil) {
                self.showMessage(title: "Erro", message: error.debugDescription)
            } else {
                var newUser = user
                newUser["foto"] = urlImage
                self.saveNewUser(newUser)
            }
        }
    }
}
