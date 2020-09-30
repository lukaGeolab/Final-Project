//
//  PurchaseViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 9/3/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class PurchaseViewController: UIViewController {
    
    var purchasedPhotoUrl = String()
    let userCollection = Firestore.firestore().collection("users")
    var users = [Users]()

    @IBOutlet var creditCard: UITextField!
    @IBOutlet var expirationMonth: UITextField!
    @IBOutlet var expirationYear: UITextField!
    @IBOutlet var CV: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        errorLabel.alpha = 0

    }
    @IBAction func purchaseButtonClicked(_ sender: Any) {
        let month = Int(expirationMonth.text ?? "00")
        let year = Int(expirationYear.text ?? "00")
        
        if creditCard.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            expirationYear.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            expirationMonth.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            CV.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            errorLabel.text = "Please fill in all fields."
            errorLabel.alpha = 1
        }else if creditCard.text?.count != 16 || expirationMonth.text?.count != 2 || month ?? 00 < 01 || month ?? 00 > 12 || expirationYear.text?.count != 2 || year ?? 00 < 20 || year ?? 00 > 40 || CV.text?.count != 3 {
            errorLabel.text = "Invalid credit card number"
            errorLabel.alpha = 1
        }else{
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
                                self.userCollection.document(user.id).updateData(["downloads":FieldValue.arrayUnion([self.purchasedPhotoUrl])])
                                PhotoData.purchasedPhoto.append(self.purchasedPhotoUrl)
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}
