//
//  DownloadedViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 9/7/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit

class DownloadedViewController: UIViewController {
    
    //MARK: Class variables
    
    var downPhotoUrl = String()
    
    //MARK: IBOutlets
    
    @IBOutlet var downImageView: UIImageView!
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downImageView.kf.setImage(with: URL(string: downPhotoUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareClicked))
    }
    
    //MARK: View setup
    
    @objc func shareClicked() {
        let ac = UIActivityViewController(activityItems: [downImageView.image!], applicationActivities: nil)
        ac.popoverPresentationController?.sourceView = self.view
        self.present(ac, animated: true, completion: nil)
    }
}
