//
//  SignUpViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/4/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
           
           // Check that all fields are filled in
           if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               
               return "Please fill in all fields."
           }
           
           // Check if the password is secure
           let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if Utilities.isPasswordValid(cleanedPassword) == false {
               // Password isn't secure enough
               return "Please make sure your password is at least 8 characters, contains a special character and a number."
           }
           
           return nil
       }
       

    @IBAction func signUpButtonClicked(_ sender: Any) {
            
            // Validate the fields
            let error = validateFields()
            
            if error != nil {
                
                // There's something wrong with the fields, show error message
                showError(error!)
            }
            else {
                
                // Create cleaned versions of the data
                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Create the user
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    
                    // Check for errors
                    if err != nil {
                        
                        // There was an error creating the user
                        self.showError("Error creating user")
                    }
                    else {
                        
                        // User was created successfully, now store the first name and last name
                        let db = Firestore.firestore()
                        let newDocument = db.collection("users").document(result!.user.uid)
                        newDocument.setData(["firstname":firstName,"lastname":lastName,"favorites": [],"downloads": []]) { (error) in
                            if error != nil {
                                // Show error message
                                self.showError("Error saving user data")
                            }
                        }
                        
                        // Transition to the home screen
                        self.transitionToHome()
                    }
                }
            }
        }
        
        func showError(_ message:String) {
            
            errorLabel.text = message
            errorLabel.alpha = 1
        }
        
        func transitionToHome() {
            let vc = TabBarController(nibName: "TabBarController", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
