//
//  FavoritesViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/23/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet var favImageCollectionView: UICollectionView!
    let userCollection = Firestore.firestore().collection("users")
    var users = [Users]()
    var favImagesUrl = [String]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favImageCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        favImageCollectionView.dataSource = self
        favImageCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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
                    let favorites = data["favorites"] as? [String] ?? ["Anonymous"]
                    let downloads = data["downloads"] as? [String] ?? []
                    let newUser = Users(uid: uid, firstName: dataFirstName, lastName: dataLastName, id: id, favorites: favorites, downloads: downloads)
                    self.users.append(newUser)
                }
                for user in self.users {
                    if user.uid == Auth.auth().currentUser?.uid {
                        if self.favImagesUrl != user.favorites {
                            self.favImagesUrl = user.favorites
                            FavData.favData = user.favorites
                        }
                    }
                }
//                self.users = []
                self.favImageCollectionView.reloadData()
            }
        }
    }
}



extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favImagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: favImagesUrl[indexPath.row]), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        vc.photoUrl = favImagesUrl[indexPath.row]
//        PhotoData.photo = favImagesUrl[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
