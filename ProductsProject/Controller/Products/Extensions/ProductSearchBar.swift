//
//  ProductSearchBar.swift
//  ProductsProject
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit



extension ProductListController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            filteredItems = itemsArray.filter { item in
                return (item.name.lowercased().contains(text.lowercased()))
            }
        }else{
            filteredItems = itemsArray
        }
        
        
        tvProducts.reloadData()
    }
}
