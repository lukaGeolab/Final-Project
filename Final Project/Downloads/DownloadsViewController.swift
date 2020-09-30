//
//  DownloadsViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/31/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class DownloadsViewController: UIViewController {

    @IBOutlet var downImagesCollectionView: UICollectionView!
    let userCollection = Firestore.firestore().collection("users")
    var users = [Users]()
    var downImagesUrl = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downImagesCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        downImagesCollectionView.dataSource = self
        downImagesCollectionView.delegate = self
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
                    let downloads = data["downloads"] as? [String] ?? ["Anonymous"]
                    let newUser = Users(uid: uid, firstName: dataFirstName, lastName: dataLastName, id: id, favorites: favorites, downloads: downloads)
                    self.users.append(newUser)
                }
                for user in self.users {
                    if user.uid == Auth.auth().currentUser?.uid {
                        for fav in user.downloads {
                            if self.downImagesUrl.contains(fav) == false {
                                self.downImagesUrl.append(fav)
                            }
                        }
                    }
                }
                self.downImagesCollectionView.reloadData()
            }
        }
    }
}

extension DownloadsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        downImagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.kf.setImage(with: URL(string: downImagesUrl[indexPath.row]), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        return cell
    }
}

extension DownloadsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DownloadedViewController(nibName: "DownloadedViewController", bundle: nil)
        vc.downPhotoUrl = downImagesUrl[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
