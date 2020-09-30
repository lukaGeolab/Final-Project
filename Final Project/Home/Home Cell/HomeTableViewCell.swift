//
//  HomeTableViewCell.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 7/10/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit


class HomeTableViewCell: UITableViewCell {

    @IBOutlet var homeImageTitle: UILabel!
    @IBOutlet var homeImageView: UIImageView!
    
    func setImage (_ image: UIImage) {
        homeImageView.image = image
    }
    
    func setTitle (_ text: String) {
        homeImageTitle.text = text
    }
}
