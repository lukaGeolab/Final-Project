//
//  HomeTableViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 7/14/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import Kingfisher

class HomeTableViewController: UIViewController {
    
    let photosCollection = Firestore.firestore().collection("mainPhotos")
    var categories = ["Animals","Architecture","Art","City","Design","Outdoors","Food","Space","Sport","People","Transport","Vintage"]
    var urls = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        
        photosCollection.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint(err)
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    for cat in self.categories {
                        let url = data[cat.lowercased()] as? String ?? "Anonymous"
                        self.urls.append(url)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
}
    
extension HomeTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? HomeCell)?.img.kf.setImage(with: URL(string: urls[indexPath.row]), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        (cell as? HomeCell)?.titleLbl.text = categories[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ImageViewController(nibName: "ImageViewController", bundle: nil)
        vc.homeTitle = categories[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        vc.navigationItem.title = categories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        print(vc.homeTitle)
        
    }
}
