//
//  AlamofireRequests.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON




class AlamofireRequests{
    
    
    
    
    //Singltone Class
    private init(){}
    
    
    
    
    
    
    //Variables
    static let instance = AlamofireRequests()
    var alamoFireManager: SessionManager?
    
    
    
    
    
    
    
    
    
    //Alamofire function for all requests
    func requestAlamofire(url: String, method: String, parameters: [String:Any]?, body: [String:Any]?,headers:[String:String]?, completion: @escaping CompletionHandler){
        
        
        //Request Arguments
        var header = headers
        var requestParameters: Parameters = parameters ?? [:]
        var parameterEncoding: ParameterEncoding = URLEncoding.queryString
        let httpMethod = HTTPMethod(rawValue: method)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30      // The request will timeout after 30 sec
        
        
        
        //iF you want to add more keys on the constant header
        for element in String_Base_Header.keys{
            header?[element] = String_Base_Header[element]
        }
        
        //Check IF The Request Has A Body Or Not
        if let body = body{
            parameterEncoding = JSONEncoding.default
            requestParameters = body
        }
        
        
        alamoFireManager?.request(url, method: httpMethod!, parameters: requestParameters, encoding: parameterEncoding, headers: header).responseJSON{ (responseJSON) in
            
            
            switch responseJSON.result{
                
            //Request Failed
            case .failure(let error):
                
                //Check Internet Connection
                if let err = error as? URLError, err.code == .notConnectedToInternet{
                    completion(false,nil,1001,Messages.ErrorMessages.NoInternet.rawValue)
                }
                //Check If Request Timeout
                if error._code == NSURLErrorTimedOut{
                    completion(false,nil,1000,Messages.ErrorMessages.Wrong.rawValue)
                }
                print(error.localizedDescription)
                
                
                
                
            //Request Successed
            case .success:
                guard let response = responseJSON.response else{
                    completion(false,nil, 500, Messages.ErrorMessages.Wrong.rawValue)
                    return
                }
                
                switch response.statusCode{
                case 200:
                    completion(true,responseJSON.data, response.statusCode, nil)
                case 500:
                    completion(false,nil, response.statusCode, Messages.ErrorMessages.Wrong.rawValue)
                default:
                    completion(false,nil, response.statusCode, "")
                }
            }
        }
    }
    
    
    
    func cancelAlamoFireRequests(){
        guard let request = alamoFireManager else{return}
        request.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach {$0.cancel()}
            uploadData.forEach      {$0.cancel()}
            downloadData.forEach    {$0.cancel()}
        }
    }
    
    
}
