//
//  LoadImageFromURL.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit



class ImageLoader: UIImageView{
    
    
    var imageUrlString: String?
    let imageCache = NSCache<AnyObject, AnyObject>()
    let defaultImage = UIImage(named: "default-Image")
    
    
    func loadImageBy(urlString:String){
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
                self.image = self.defaultImage
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                self.imageCache.setObject(imageToCache!, forKey: imageURL as AnyObject)
            }
        }.resume()
        
        
        
    }
}
