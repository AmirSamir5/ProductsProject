//
//  Data.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//


struct RootModelData: Decodable {
    
    var product: [ModelProduct]
    
    private enum CodingKeys: String,CodingKey{
        case product = "data"
    }
}

struct ModelProduct: Decodable {
    
    var id: Int
    var name: String
    var productDescription: String
    var price : Double
    var image: ModelProductImage
    
    private enum CodingKeys: String, CodingKey{
        case id, name, productDescription, price, image
    }
}
