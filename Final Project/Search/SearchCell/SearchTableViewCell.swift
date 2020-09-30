//
//  SearchTableViewCell.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/6/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var setText: UILabel!
    
    func setTitle (_ text: String) {
        setText.text = text
    }
}
