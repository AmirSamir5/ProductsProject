//
//  NetworkProductData.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import Foundation


class NetworkProductData{
    
    //Get Products Request and return Array Of Model Data if success or Error Message If Fail
    public static func getAllProducts(successed: @escaping (_ productData: RootModelData) -> (), failed: @escaping(_ errorMsg: String) ->()){
        var rootData: RootModelData?
        
        NetworkingServices.instance.get(url: BASE_URL, parameters: nil, body: nil) { (success, response, statusCode, errorMsg) in
            
            
            if success{
                rootData = decode(decodable: RootModelData.self, data: response as! Data)
                guard let rootData = rootData else{
                    failed(Messages.ErrorMessages.Wrong.rawValue)
                    return
                }
                successed(rootData)
            }else{
                switch statusCode{
                case 404:
                    failed(Messages.ErrorMessages.NoProducts.rawValue)
                default:
                    failed(Messages.ErrorMessages.Wrong.rawValue)
                }
            }
        }
    }
}
