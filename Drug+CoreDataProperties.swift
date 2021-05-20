//
//  Drug+CoreDataProperties.swift
//  DrugCounterWatch Extension
//
//  Created by Abigail Aryaputra Sudarman on 25/02/21.
//
//

import Foundation
import CoreData


extension Drug {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drug> {
        return NSFetchRequest<Drug>(entityName: "Drug")
    }

    @NSManaged public var color: String?
    @NSManaged public var dailyIntake: Int32
    @NSManaged public var dosage: Int32
    @NSManaged public var histories: NSObject?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var shape: String?

}

extension Drug : Identifiable {

}
