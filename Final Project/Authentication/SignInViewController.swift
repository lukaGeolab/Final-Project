//
//  SignInViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/3/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 25.0
        logInButton.layer.borderWidth = 2
    }
    
    @IBAction func logInButtonClicked(_ sender: Any) {
        let vc = LogInViewController(nibName: "LogInViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func registrationButtonClicked(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }


}

