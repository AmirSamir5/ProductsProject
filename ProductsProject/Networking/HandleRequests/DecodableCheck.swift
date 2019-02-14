//
//  DecodableCheck.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import Foundation




func decode<T>(decodable: T.Type,data: Data) -> T? where T : Decodable{
    do {
        let responseModel = try JSONDecoder().decode(decodable, from: data)
        print(responseModel)
        return responseModel
        
    } catch DecodingError.keyNotFound(let key, let context) {
        print("not found key is \(key))")
        print("context = \(context)")
        
    }catch DecodingError.valueNotFound(let type, let context){
        print("not found")
        print("type: \(type) , context: \(context)")
        
    }catch DecodingError.typeMismatch(let type , let context){
        print("mismatch")
        print("type: \(type) , context: \(context)")
        
    }catch DecodingError.dataCorrupted(let context) {
        print("corrupted context is \(context)")
    }
        
    catch {
        print("undefined")
    }
    
    return nil
}
