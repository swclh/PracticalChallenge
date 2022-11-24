//
//  ULCoordinates+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULCoordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULCoordinates> {
        return NSFetchRequest<ULCoordinates>(entityName: "ULCoordinates")
    }

    @NSManaged public var longitude: String?
    @NSManaged public var latitude: String?
    @NSManaged public var location: ULLocation?

}
