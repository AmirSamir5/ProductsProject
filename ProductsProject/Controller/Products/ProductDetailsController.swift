//
//  ProductDetailsController.swift
//  ProductsProject
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailsController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemImageHeight: NSLayoutConstraint!
    

    
    
    
    //MARK:- Variables
    var selectedId: Int?
    
    
    
    
    
    
    //MARK:- Views
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        FilterCoreData()
    }
    
    
    
    
    
    
    
    
    //MARK:- Setup Functions
    func uiSetup(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    func FilterCoreData(){
        let fetchRequest = NSFetchRequest<Product>(entityName: CoreDataManager.instance.moduleName)
        fetchRequest.predicate = NSPredicate(format: "itemId == %@", "\(Int16(selectedId!))")
        
        do{
            let item = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest).first
            guard let productItem = item else { return }
            guard let image = productItem.itemImage else { return }
            
            let height = Int(productItem.imageHeight)
            let width  = Int(productItem.imageWidth)
            
            itemName.text = productItem.itemTitle
            itemPrice.text = "Price: \(productItem.itemPrice) EGP"
            itemImage.image = UIImage(data: image)
            itemImageHeight.constant = CGFloat(((Int(UIScreen.main.bounds.width) - 32) * height) / width)
        }catch{
            fatalError("error executing fetch request")
        }
    }
}




























