//
//  MessageController.swift
//  SharingIOS
//
//  Created by iossenac on 02/12/17.
//  Copyright © 2017 iossenac. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController
import MobileCoreServices
import AVKit

class MessageController: JSQMessagesViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //@IBOutlet weak var messageTextView: UITextField!
    //@IBOutlet weak var sendButton: UIButton!
    
    private var messages = [JSQMessage]()
    
    var user:[String:Any]!
    let databaseManager = DatabaseManager()
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        getUserProfileData()
        
        self.senderId = Auth.auth().currentUser?.uid
        self.senderDisplayName = "Alan"
        
        print("Id " + senderId)
        print("Name " + senderDisplayName)
        
    }
    
    func getUserProfileData() {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = self.databaseManager.getReferenceByUid(node: "usuario", uid: uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                self.user = snapshot.value as? NSDictionary as! [String : Any]
            }) { (error) in
                self.showMessage(title: "Erro", message: error.localizedDescription)
            }
        }
    }
    
    // Funções CollectionView - JSQMessages
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        //let message = messages[indexPath.item]
        
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "profileicon"), diameter: 30)
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        MessagesHandler.Instance.sendMessage(senderId: senderId, senderName: senderDisplayName, text: text)
        
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        collectionView.reloadData()
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let msg = messages[indexPath.item]
        if msg.isMediaMessage {
            if let mediaItem = msg.media as? JSQVideoMediaItem {
                let player = AVPlayer(url: mediaItem.fileURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let alert = UIAlertController(title: "Media Messages", message: "Selecione uma foto ou vídeo", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let photos = UIAlertAction(title: "Photos", style: .default, handler: { (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeImage)
        })
        let videos = UIAlertAction(title: "Videos", style: .default, handler: { (alert: UIAlertAction) in
            self.chooseMedia(type: kUTTypeMovie)
        })
        alert.addAction(photos)
        alert.addAction(videos)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    private func chooseMedia(type: CFString) {
        picker.mediaTypes = [type as String]
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pic = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let img = JSQPhotoMediaItem(image: pic)
            self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: img))
            
        } else if let vidUrl = info[UIImagePickerControllerMediaURL] as? URL {
            
            let video = JSQVideoMediaItem(fileURL: vidUrl, isReadyToPlay: true)
            self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: video))
            
        }
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
}
