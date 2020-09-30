//
//  UserViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/3/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class UserViewController: UIViewController {
    
    let userCollection = Firestore.firestore().collection("users")
    var users = [Users]()
    var userID = String()
    
    @IBOutlet var firstNameText: UITextView!
    @IBOutlet var lastNameText: UITextView!
    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        if user.uid == Auth.auth().currentUser?.uid {
                            self.firstNameLabel.text = user.firstName
                            self.lastNameLabel.text = user.lastName
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        let appDelegate = AppDelegate()
        appDelegate.resetApp()
    }
    
    
    
    
    
    
}
