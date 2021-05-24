//
//  NotificationEntity+CoreDataProperties.swift
//  DrugCounter2
//
//  Created by Abigail Aryaputra Sudarman on 23/05/21.
//
//

import Foundation
import CoreData


extension NotificationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationEntity> {
        return NSFetchRequest<NotificationEntity>(entityName: "NotificationEntity")
    }

    @NSManaged public var drugName: String?
    @NSManaged public var time: Int32
    @NSManaged public var requestIdentifier: String?

}

extension NotificationEntity : Identifiable {

}
