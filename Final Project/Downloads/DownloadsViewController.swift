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
    
    var downImagesUrl = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getDownloads()
    }
    
    func setupCollectionView() {
        downImagesCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        downImagesCollectionView.dataSource = self
        downImagesCollectionView.delegate = self
    }
    
    func getDownloads() {
        FavData.getCurrentUserData { [weak self] userData in
            self?.downImagesUrl = userData.downloads
            self?.downImagesCollectionView.reloadData()
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
