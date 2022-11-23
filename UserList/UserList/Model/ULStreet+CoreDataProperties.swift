//
//  ULStreet+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULStreet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULStreet> {
        return NSFetchRequest<ULStreet>(entityName: "ULStreet")
    }

    @NSManaged public var number: Int64
    @NSManaged public var name: String?
    @NSManaged public var location: ULLocation?

}
