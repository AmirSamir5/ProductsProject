//
//  ProductListController.swift
//  ProductsProject
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit
import CoreData





class ProductListController: UIViewController {

    
    
    //MARK:- Outlets
    @IBOutlet weak var tvProducts: UITableView!
    
    
    
    
    
    
    
    //MARK:- Varialbes
    let spinner = Spinner()
    let coreDataManager = CoreDataManager()
    var itemStruct: Items?
    var itemsArray = [Items]()
    var filteredItems = [Items]()
    var productApiArr = [ModelProduct]()
    var loadedFromCoreData = false
    var searchController : UISearchController!
    var selectedId: Int?
    
    
    
    
    
    
    //MARK:- Views
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        setSearch()
        checkCoreData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    
    
    
    //MARK:- Structures
    struct Items : Hashable {
        var id: Int
        var name: String
        var price: Double
        var image: Data?
        var link: String?
        var width: Int
        var height: Int
    }
    
    
    
    
    
    
    
    
    //MARK:- Setup Functions
    func uiSetup(){
        tvProducts.dataSource = self
        tvProducts.delegate   = self
        tvProducts.register(UINib(nibName: Cell_Product, bundle: nil), forCellReuseIdentifier: Cell_Product)
        self.title = "Products List"
    }
    
    //Set Search Bar For Items
    func setSearch(){
        let search = setSearchBar(navItem: self.navigationItem, navController: self.navigationController!, viewController: self, placeholder:  Messages.Titles.Search.rawValue, tableView: tvProducts)
        search.searchResultsUpdater = self
        searchController = search
    }
    
    
    //Check IF There is A Data In CoreData Or Not
    func checkCoreData(){
        
        let fetchRequest = NSFetchRequest<Product>(entityName: CoreDataManager.instance.moduleName)
        
        do{
            let product = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            
            if product.isEmpty{
                //Load From Api
                loadedFromCoreData = false
                getAllProducts()
                
            }else{
                
                //Load From CoreData
                loadedFromCoreData = true
                for item in product{
                    guard let title = item.itemTitle else { return }
                    guard let image = item.itemImage else { return }
                    
                    self.itemStruct = Items(id: Int(item.itemId), name: title, price: item.itemPrice, image: image, link: nil, width: Int(item.imageWidth), height: Int(item.imageHeight))
                    self.itemsArray.append(self.itemStruct!)
                }
                self.filteredItems = itemsArray
                tvProducts.reloadData()
            }
        }catch{
            getAllProducts()
            fatalError("Couldn't Fetch Data")
        }
    }
    
    
    
    
    
    
    
    
    //MARK:- Server Functions
    func getAllProducts(){
        spinner.startLoading(viewOfScroll: self.view, message: Messages.LoadingMessages.Products.rawValue)
        
        NetworkProductData.getAllProducts(successed: { [weak self] (rootData) in
            
            guard let self = self else { return }
            self.productApiArr = rootData.product
            self.saveToCoreData()
            self.tvProducts.reloadData()
            self.spinner.stopLoading(viewOfScroll: self.view)
            
        }) { [weak self] (errorMsg) in
            
            guard let self = self else { return }
            self.getProductsFailed()
            self.spinner.stopLoading(viewOfScroll: self.view)
            
        }
    }
    
    
    //Save To Core Data And Fill Items Array
    func saveToCoreData(){
        for item in self.productApiArr{
            
            let product = Product(context: CoreDataManager.instance.managedObjectContext)
            
            
            //Append To CoreData
            product.itemId = Int16(item.id)
            product.itemTitle = item.name
            product.itemPrice = item.price
            product.imageHeight = Int16(item.image.height) ?? 0
            product.imageWidth  = Int16(item.image.width) ?? 0
            
            CoreDataManager.instance.saveContext()
            
            //Fill Items Array
            self.itemStruct = Items(id: item.id, name: item.name, price: item.price, image: nil, link: item.image.link, width: Int(item.image.width) ?? 0, height: Int(item.image.height) ?? 0)
            self.itemsArray.append(self.itemStruct!)
        }
        self.filteredItems = itemsArray
    }
    
    func getProductsFailed(){
        
    }
    
    
    
    //MARK:- Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductDetailsController {
            destination.selectedId = selectedId
        }
    }
}
