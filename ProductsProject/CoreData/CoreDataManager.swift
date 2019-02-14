//
//  CoreDataManager.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    
    private static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    static func storeObj(){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ProductsModel", in: context)
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
//        managedObj.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
    }
    static func fetchObj(){
        
    }
}





































