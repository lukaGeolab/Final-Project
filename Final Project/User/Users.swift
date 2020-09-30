//
//  Users.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/21/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import Foundation
import UIKit

class Users {
    var uid = ""
    var firstName = ""
    var lastName = ""
    var id = ""
    var favorites: [String] = []
    var downloads: [String] = []
    
    init(uid: String, firstName: String, lastName: String, id: String, favorites: [String], downloads: [String]) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.favorites = favorites
        self.downloads = downloads
    }
}







