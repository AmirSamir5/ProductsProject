//
//  AppConstants.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//






//MARK:- Typealias
typealias CompletionHandler = (_ Success: Bool,_ JSONObject: Any?,_ StatusCode: Int,_ errorMsg: String?) -> ()





//MARK:- Static Variables
let String_Base_Header = [ "Content-Type":"application/json" ]






//MARK:- URL Strings
let BASE_URL = "https://limitless-forest-98976.herokuapp.com"






//MARK:- Cells Names
let Cell_Product = "ProductTableViewCell"








//MARK:- Segues Names
let GoTo_ProductDetails = "GoToProductDetails"









//MARK:- Messages
struct Messages{
    
    enum Titles: String{
        case OK             = "OK"
        case Done           = "Done"
        case DoneAction     = "Success"
        case Search         = "Search"
        case cancel         = "Cancel"
    }
    
    enum LoadingMessages: String {
        case Products       = "Loading All Products"
        case ProductDetails = "Loading Product Details"
    }
    
    enum ErrorMessages: String{
        case Wrong          = "Something Went Wrong"
        case NoInternet     = "Please Check Your Internet Connection"
        case NoProducts     = "Products Not Found"
    }
}




