//
//  CoreDataManager.swift
//  ProductsProject
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit
import CoreData




//This File Created To Be Our Reference For CoreData Instead Of AppDelegate
class CoreDataManager: NSObject {
    
    let moduleName = "Product"
    static let instance = CoreDataManager()
    
    //Create a mananged object module for our Product Project
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    
    //Set Our Store Directory to be a document Directory
    lazy var applicationDocumentsDirectory: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()
    
    //Set The Coordinator to save our data in this document directory
    lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let persistentStoreURL = self.applicationDocumentsDirectory.appendingPathComponent("\(moduleName).sqlite")
        
        do{
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: [NSMigratePersistentStoresAutomaticallyOption:true,NSInferMappingModelAutomaticallyOption:true])
        }catch{
            fatalError("Presistent Store Error !!!!!)")
        }
        return coordinator
    }()
    
    //And Finally apply The PresistentStoreCoordinator to Our ManagedObjectContext
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }()
    
    
    func saveContext(){
        if managedObjectContext.hasChanges{
            do{
                try managedObjectContext.save()
            }catch{
                fatalError("An Error While Saving Managed Object Context !!!")
            }
        }
    }
}





































