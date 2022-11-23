//
//  ULID+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULID> {
        return NSFetchRequest<ULID>(entityName: "ULID")
    }

    @NSManaged public var value: String?
    @NSManaged public var name: String?
    @NSManaged public var user: ULUser?

}
