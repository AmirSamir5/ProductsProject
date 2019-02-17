//
//  ProductTableView.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//


import UIKit



extension ProductListController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell_Product, for: indexPath) as? ProductTableViewCell else {return UITableViewCell()}
        
        let item = filteredItems[indexPath.row]
        let imageHeight = Int(item.height)
        let imageWidth  = Int(item.width)
        
        cell.cellId                   = item.id
        cell.itemTitle.text           = item.name
        cell.itemPrice.text           = "Price: \(item.price) EGP"
        cell.itemImageHeight.constant = CGFloat(((Int(UIScreen.main.bounds.width) - 32) * imageHeight) / imageWidth)
        cell.selectionStyle           = .none
        
        if loadedFromCoreData {
            guard let imageData = item.image else { return cell}
            cell.itemImage.image = UIImage(data: imageData)
        }else{
            cell.itemImage.loadAndSaveImage(urlString: item.link ?? "", product_id: item.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell else { return }
        selectedId = cell.cellId
        performSegue(withIdentifier: GoTo_ProductDetails, sender: self)
    }
}
