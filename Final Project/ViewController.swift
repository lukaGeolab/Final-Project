//
//  ViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 7/9/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet var welcomeButton: UIButton!
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: View setup
    
    @IBAction func welcomeButtonClicked(_ sender: Any) {
        let vc = SignInViewController(nibName: "SignInViewController", bundle: nil)
        //        let vc = TabBarController(nibName: "TabBarController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


