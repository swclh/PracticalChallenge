//
//  ULRegistered+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULRegistered {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULRegistered> {
        return NSFetchRequest<ULRegistered>(entityName: "ULRegistered")
    }

    @NSManaged public var date: String?
    @NSManaged public var age: Int64
    @NSManaged public var user: ULUser?

}
