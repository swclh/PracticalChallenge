//
//  ULCoordinates+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULCoordinates)
public class ULCoordinates: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        latitude = data["latitude"] as? String
        longitude = data["longitude"] as? String
    }
}
