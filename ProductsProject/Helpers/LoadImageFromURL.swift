//
//  LoadImageFromURL.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit
import CoreData


class ImageLoader: UIImageView{
    
    
    var imageUrlString: String?
    var cellIndex: Int?
    let imageCache = NSCache<AnyObject, AnyObject>()
    let defaultImage = UIImage(named: "default-Image")
    
    
    func loadAndSaveImage(urlString:String,product_id: Int){
        
        imageUrlString = urlString
        let url = URL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        guard let imageURL = url else{ return }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error != nil{
                if self.imageUrlString == urlString{
                    self.image = self.defaultImage
                }
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                    
                    //Save Image To Core Data
                    let fetchRequest = NSFetchRequest<Product>(entityName: CoreDataManager.instance.moduleName)
                    do{
                        let product = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
                        
                        product.filter{$0.itemId == product_id}.first!.itemImage = imageToCache?.pngData()
                        
                        CoreDataManager.instance.saveContext()
                    }catch{
                        fatalError("Couldn't Fetch Data")
                    }
                }
                self.imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
        }.resume()
    }
}
