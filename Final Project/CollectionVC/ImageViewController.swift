//
//  ImageViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/9/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class ImageViewController: UIViewController {
    
    //MARK: Class variables
    
    let photosCollection = Firestore.firestore().collection("photos")
    var homeTitle = String()
    var images: [UIImage] = []
    var users = [Users]()
    let userCollection = Firestore.firestore().collection("users")

    
    //MARK: IBOutlets
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
    //MARK: View lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        photosCollection.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint(err)
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let array = data[self.homeTitle.lowercased()] as? [String] ?? []
                    PhotoData.photoDatas = array
                }
                self.imageCollectionView.reloadData()
            }
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
                        }
                    }
                }
            }
        }
    }
}
extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PhotoData.photoDatas.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: PhotoData.photoDatas[indexPath.row]), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        return cell
    }
}
extension ImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        vc.photoUrl = PhotoData.photoDatas[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


