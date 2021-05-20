//
//  History+CoreDataProperties.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 25/02/21.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var drugID: String?
    @NSManaged public var drugName: String?
    @NSManaged public var timeTaken: Date?

}

extension History : Identifiable {

}
