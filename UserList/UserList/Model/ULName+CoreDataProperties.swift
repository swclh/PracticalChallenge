//
//  ULName+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULName> {
        return NSFetchRequest<ULName>(entityName: "ULName")
    }

    @NSManaged public var title: String?
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var user: ULUser?

}
