//
//  ProductTableViewCell.swift
//  ProductsProject
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    
    //MARK:- Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemImage: ImageLoader!
    @IBOutlet weak var itemImageHeight: NSLayoutConstraint!
    
    
}
