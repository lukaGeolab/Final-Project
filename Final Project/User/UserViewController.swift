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
    
    @IBOutlet var firstNameText: UITextView!
    @IBOutlet var lastNameText: UITextView!
    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserLbls()
    }
    
    func configureUserLbls() {
        FavData.getCurrentUserData { [weak self] userData in
            self?.firstNameLabel.text = userData.firstName
            self?.lastNameLabel.text = userData.lastName
        }
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        let appDelegate = AppDelegate()
        appDelegate.resetApp()
    }
}
