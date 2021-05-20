//
//  PersistenceController.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 06/12/20.
//

import Foundation
import CoreData

struct PersistenceController {
    static let sharedInstance = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    init() {
        container = NSPersistentCloudKitContainer(name: "DrugCounter2")
        
        let description = container.persistentStoreDescriptions.first

               description?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.rinne.drugtracker")
               
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved Error: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
