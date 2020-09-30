//
//  Users.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/21/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import Foundation
import UIKit

class UserData {
    var firstName = ""
    var lastName = ""
    var favorites: [String] = []
    var downloads: [String] = []
    
    init(dict: [String : Any]) {
        self.firstName = dict["firstname"] as? String ?? ""
        self.lastName = dict["lastname"] as? String ?? ""
        self.favorites = dict["favorites"] as? [String] ?? []
        self.downloads = dict["downloads"] as? [String] ?? []
    }
}







