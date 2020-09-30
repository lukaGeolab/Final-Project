//
//  SearchTableViewController.swift
//  Final Project
//
//  Created by Luka Khaburdzania on 8/6/20.
//  Copyright © 2020 Luka Khaburdzania. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    var categories = ["Animals","Architecture","Art","City","Design","Outdoors","Food","Space","Sport","People","Transport","Vintage"]
    var searchedCategories = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        hideKeyboardWhenTappedAround()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCategories.count
        } else {
            return categories.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath)
        
        }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
       if searching {
            (cell as? SearchTableViewCell)?.textLabel?.text = searchedCategories[indexPath.row]
        
        } else {
            (cell as? SearchTableViewCell)?.textLabel?.text = categories[indexPath.row]

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ImageViewController(nibName: "ImageViewController", bundle: nil)
        
        if searching {
            vc.homeTitle = searchedCategories[indexPath.row]
            vc.navigationItem.title = searchedCategories[indexPath.row]
        } else {
            vc.homeTitle = categories[indexPath.row]
            vc.navigationItem.title = categories[indexPath.row]
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        print(vc.homeTitle)
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCategories = categories.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
}
