//
//  SearchController.swift
//  ProductsProject
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit



//ADD SEARCH BAR TO A CERTAIN CONTROLLER
func setSearchBar(navItem: UINavigationItem , navController: UINavigationController, viewController: UIViewController,placeholder: String,tableView: UITableView?) -> UISearchController{
    
    
    let search = UISearchController(searchResultsController: nil)
    search.obscuresBackgroundDuringPresentation = false
    search.searchBar.placeholder = placeholder
    search.searchBar.tintColor = UIColor.white
    navController.navigationBar.prefersLargeTitles = true
    
    if #available(iOS 11.0, *) {
        navItem.searchController = search
    } else {
        // Fallback on earlier versions
        if let tableview = tableView {
            tableview.tableHeaderView = search.searchBar
        }
    }
    
    
    if #available(iOS 11.0, *) {
        navItem.hidesSearchBarWhenScrolling = true
    } else {
        // Fallback on earlier versions
    }
    
    
    navController.navigationBar.barStyle = .black
    viewController.definesPresentationContext = true
    return search
}

