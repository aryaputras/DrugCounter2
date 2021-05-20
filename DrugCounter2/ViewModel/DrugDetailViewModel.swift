//
//  DrugDetailViewModel.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 20/05/21.
//

import Foundation
import CoreData

class DrugDetailViewModel: ObservableObject {
    let container: NSPersistentCloudKitContainer
    @Published var savedEntities: [History] = []
    init() {
        container = NSPersistentCloudKitContainer(name: "DrugCounter2")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error)
            }
        }
        fetchDrugs()
    }

    func fetchDrugs() {
        let request = NSFetchRequest<History>(entityName: "History")

        do {
            savedEntities = try container.viewContext.fetch(request)
            print("savedEntities")
        } catch let error {
            print(error)
        }
    }
}
