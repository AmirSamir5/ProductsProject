//
//  ProductListController.swift
//  ProductsProject
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit

class ProductListController: UIViewController {

    
    //MARK:- Outlets
    @IBOutlet weak var tvProducts: UITableView!
    
    
    
    
    
    //MARK:- Varialbes
    var productArray = [ModelProduct]()
    
    
    
    
    
    
    //MARK:- Views
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSetup()
    }
    
    
    
    
    
    
    //MARK:- Setup Functions
    func uiSetup(){
        tvProducts.dataSource = self
        tvProducts.delegate   = self
        tvProducts.register(UINib(nibName: Cell_Product, bundle: nil), forCellReuseIdentifier: Cell_Product)
    }
    
    
    
    
    
    
    //MARK:- Server Functions
    func getAllProducts(){
        NetworkProductData.getAllProducts(successed: { [weak self] (rootData) in
            
            guard let self = self else { return }
            self.productArray = rootData.product
            self.tvProducts.reloadData()
            
        }) { [weak self] (errorMsg) in
            
            guard let self = self else { return }
            
            
        }
    }
    
    
    
    
    
    
    
}
