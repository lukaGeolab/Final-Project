//
//  LogInViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/3/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LogInViewController: UIViewController {
    
    //MARK: Class variables
    
    let db = Firestore.firestore()
    
    //MARK: IBOutlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        hideKeyboardWhenTappedAround()
        logInButton.layer.cornerRadius = 25.0
        logInButton.layer.borderWidth = 2
    }
    
    @IBAction func logInButtonClicked(_ sender: Any) {
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                let vc = TabBarController(nibName: "TabBarController", bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
