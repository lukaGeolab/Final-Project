//
//  CollectionViewCell.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/9/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage (_ image: UIImage) {
        imageView.image = image
    }
}
