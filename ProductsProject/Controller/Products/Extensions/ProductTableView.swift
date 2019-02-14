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
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell_Product, for: indexPath) as? ProductTableViewCell else {return UITableViewCell()}
        
        let product = productArray[indexPath.row]
        let imageHeight = product.image.height
        let imageWidth  = product.image.width
        
        cell.itemTitle.text = product.name
        cell.itemPrice.text = "Price: \(product.price) EGP"
        cell.itemImage.loadImageBy(urlString: product.image.link)
        cell.itemImageHeight.constant = CGFloat(((Int(UIScreen.main.bounds.width) - 32) * imageHeight) / imageWidth)
        
        return cell
    }
}
