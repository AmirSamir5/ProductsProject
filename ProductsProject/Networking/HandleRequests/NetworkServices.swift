//
//  NetworkServices.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import Foundation


class NetworkingServices {
    
    private init() {}
    static let instance = NetworkingServices()
    
    
    
    
    
    enum HttpMethod :String{
        case post = "POST"
        case delete = "DELETE"
        case get = "GET"
        case update = "UPDATE"
    }
    
    
    
    
    func get(url:String,parameters: [String:Any]?,body:[String:Any]?,headers:[String:String]? = [:],completion: @escaping CompletionHandler){
        AlamofireRequests.instance.requestAlamofire(url: url, method: HttpMethod.get.rawValue, parameters: parameters, body: body, headers: headers, completion: completion)
    }
    func post(url:String,parameters: [String:Any]?,body:[String:Any]? = [:],headers:[String:String]? = [:],completion: @escaping CompletionHandler){
        AlamofireRequests.instance.requestAlamofire(url: url, method: HttpMethod.post.rawValue, parameters: parameters, body: body, headers: headers, completion: completion)
    }
    func delete(url:String,parameters: [String:Any]?,body:[String:Any]? = [:],headers:[String:String]? = [:],completion: @escaping CompletionHandler){
        AlamofireRequests.instance.requestAlamofire(url: url, method: HttpMethod.delete.rawValue, parameters: parameters, body: body, headers: headers, completion: completion)
    }
    func update(url:String,parameters: [String:Any]?,body:[String:Any]? = [:],headers:[String:String]? = [:],completion: @escaping CompletionHandler){
        AlamofireRequests.instance.requestAlamofire(url: url, method: HttpMethod.update.rawValue, parameters: parameters, body: body, headers: headers, completion: completion)
    }
    
}
