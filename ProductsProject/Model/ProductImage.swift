//
//  ProductImage.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//


struct ModelProductImage: Decodable{
    
    var link: String
    var height: String
    var width: String
    
    private enum CodingKeys: String, CodingKey{
        case link, height, width
    }
}
