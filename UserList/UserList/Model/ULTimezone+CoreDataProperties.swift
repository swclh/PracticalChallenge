//
//  ULTimezone+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULTimezone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULTimezone> {
        return NSFetchRequest<ULTimezone>(entityName: "ULTimezone")
    }

    @NSManaged public var offset: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var location: ULLocation?

}
