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
    let userCollection = Firestore.firestore().collection("users")
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
        photoImageView.kf.setImage(with: URL(string: photoUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        configureFavoriteState()
    }
    
    @IBAction func addFavBtnClicked(_ sender: Any) {
        self.addFavBtn.isHidden.toggle()
        self.removeFavBtn.isHidden.toggle()
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        self.userCollection.document(currentUserId).updateData(["favorites":FieldValue.arrayUnion([photoUrl])])
    }
    
    @IBAction func removeFavBtnClicked(_ sender: Any) {
        self.addFavBtn.isHidden.toggle()
        self.removeFavBtn.isHidden.toggle()
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        self.userCollection.document(currentUserId).updateData(["favorites":FieldValue.arrayRemove([photoUrl])])
    }
    

    func configureFavoriteState() {
        FavData.getCurrentUserData { [weak self] userData in
            guard let photoUrl = self?.photoUrl else { return }
            let isFavorite = userData.favorites.contains(photoUrl)
            self?.addFavBtn.isHidden = isFavorite
            self?.removeFavBtn.isHidden = !isFavorite
        }
    }
}
