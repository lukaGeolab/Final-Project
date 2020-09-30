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
    
    //MARK: Class variables
    
    var favImagesUrl = [String]()
    
    
    //MARK: IBOutlets
    
    @IBOutlet var favImageCollectionView: UICollectionView!
    
    //MARK: View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavData()
    }
    
    //MARK: View setup
    
    func setupCollectionView() {
        favImageCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        favImageCollectionView.dataSource = self
        favImageCollectionView.delegate = self
    }
    
    func getFavData() {
        FavData.getCurrentUserData { [weak self] userData in
            self?.favImagesUrl = userData.favorites
            self?.favImageCollectionView.reloadData()
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
