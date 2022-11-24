//
//  ULDob+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULDob {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULDob> {
        return NSFetchRequest<ULDob>(entityName: "ULDob")
    }

    @NSManaged public var date: String?
    @NSManaged public var age: Int64
    @NSManaged public var user: ULUser?

}
