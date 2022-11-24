//
//  ULLogin+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULLogin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULLogin> {
        return NSFetchRequest<ULLogin>(entityName: "ULLogin")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var username: String?
    @NSManaged public var salt: String?
    @NSManaged public var password: String?
    @NSManaged public var user: ULUser?

}
