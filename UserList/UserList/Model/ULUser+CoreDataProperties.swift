//
//  ULUser+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULUser> {
        return NSFetchRequest<ULUser>(entityName: "ULUser")
    }

    @NSManaged public var phone: String?
    @NSManaged public var page: Int64
    @NSManaged public var nat: String?
    @NSManaged public var gender: String?
    @NSManaged public var email: String?
    @NSManaged public var cell: String?
    @NSManaged public var dob: ULDob?
    @NSManaged public var id: ULID?
    @NSManaged public var location: ULLocation?
    @NSManaged public var login: ULLogin?
    @NSManaged public var name: ULName?
    @NSManaged public var picture: ULPicture?
    @NSManaged public var registered: ULRegistered?

}
