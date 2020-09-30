//
//  PhotoViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 9/27/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class PhotoViewController: UIViewController {

    @IBOutlet var removeFavBtn: UIButton!
    @IBOutlet var addFavBtn: UIButton!
    var photoUrl = String()
    var image = UIImage()
    var text = String()
    let userCollection = Firestore.firestore().collection("users")
    var users = [Users]()
    var favorites = [String]()
    
    @objc func purchaseClicked() {
        let vc = PurchaseViewController(nibName: "PurchaseViewController", bundle: nil)
        if PhotoData.purchasedPhoto.contains(photoUrl) {
            let alert = UIAlertController(title: "You've already purchased this photo", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            vc.purchasedPhotoUrl = photoUrl
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var photoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Purchase", style: .plain, target: self, action: #selector(purchaseClicked))
        
        if FavData.favData.contains(photoUrl) {
            self.addFavBtn.isHidden = true
            self.addFavBtn.isEnabled = false
            self.removeFavBtn.isHidden = false
            self.removeFavBtn.isEnabled = true
        } else {
            self.addFavBtn.isHidden = false
            self.addFavBtn.isEnabled = true
            self.removeFavBtn.isHidden = true
            self.removeFavBtn.isEnabled = false
        }
        
        userCollection.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint(err)
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let uid = data["uid"] as? String ?? "Anonymous"
                    let dataFirstName = data["firstname"] as? String ?? "Anonymous"
                    let dataLastName = data["lastname"] as? String ?? "Anonymous"
                    let id = data["id"] as? String ?? "Anonymous"
                    let favorites = data["favorites"] as? [String] ?? []
                    let downloads = data["downloads"] as? [String] ?? []
                    let newUser = Users(uid: uid, firstName: dataFirstName, lastName: dataLastName, id: id, favorites: favorites, downloads: downloads)
                    self.users.append(newUser)
                    for user in self.users {
                        if Auth.auth().currentUser?.uid == user.uid {
                            FavData.favData = user.favorites
                            PhotoData.purchasedPhoto = user.downloads
                        }
                    }
                }
            }
        }
        
        photoImageView.kf.setImage(with: URL(string: photoUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        
    }
    
    @IBAction func addFavBtnClicked(_ sender: Any) {
        
        self.addFavBtn.isHidden = true
        self.addFavBtn.isEnabled = false
        self.removeFavBtn.isHidden = false
        self.removeFavBtn.isEnabled = true
        for user in self.users {
            if user.uid == Auth.auth().currentUser?.uid {
                self.userCollection.document(user.id).updateData(["favorites":FieldValue.arrayUnion([photoUrl])])
            }
        }


    }
    
    @IBAction func removeFavBtnClicked(_ sender: Any) {
        
        self.addFavBtn.isHidden = false
        self.addFavBtn.isEnabled = true
        self.removeFavBtn.isHidden = true
        self.removeFavBtn.isEnabled = false
        for user in self.users {
            if user.uid == Auth.auth().currentUser?.uid {
                self.userCollection.document(user.id).updateData(["favorites":FieldValue.arrayRemove([photoUrl])])
            }
        }
    }
    

}
