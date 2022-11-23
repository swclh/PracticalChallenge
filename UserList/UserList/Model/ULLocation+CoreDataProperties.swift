//
//  ULLocation+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULLocation> {
        return NSFetchRequest<ULLocation>(entityName: "ULLocation")
    }

    @NSManaged public var state: String?
    @NSManaged public var postcode: String?
    @NSManaged public var country: String?
    @NSManaged public var city: String?
    @NSManaged public var coordinates: ULCoordinates?
    @NSManaged public var street: ULStreet?
    @NSManaged public var timezone: ULTimezone?
    @NSManaged public var user: ULUser?

}
