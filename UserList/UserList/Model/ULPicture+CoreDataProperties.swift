//
//  ULPicture+CoreDataProperties.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData


extension ULPicture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ULPicture> {
        return NSFetchRequest<ULPicture>(entityName: "ULPicture")
    }

    @NSManaged public var thumbnail: String?
    @NSManaged public var medium: String?
    @NSManaged public var large: String?
    @NSManaged public var user: ULUser?

}
