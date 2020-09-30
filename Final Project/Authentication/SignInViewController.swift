//
//  SignInViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/3/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet var LogInButton: UIButton!
    @IBOutlet var RegistrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LogInButtonClicked(_ sender: Any) {
        let vc = LogInViewController(nibName: "LogInViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func RegistrationButtonClicked(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }


}

