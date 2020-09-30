//
//  FavData.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 9/6/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FavData {
    
    static func getCurrentUserData(completionHandler: @escaping (UserData) -> Void) {
        let userCollection = Firestore.firestore().collection("users")
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        userCollection.document(currentUserId).getDocument { (snapshot, error) in
            if let error = error {
                debugPrint(error)
            } else if let document = snapshot,
                      let data = document.data() {
                let userData = UserData(dict: data)
                completionHandler(userData)
            }
        }
    }
}
