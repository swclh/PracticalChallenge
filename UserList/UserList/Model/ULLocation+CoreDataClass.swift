//
//  ULLocation+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULLocation)
public class ULLocation: ULManagedObject {
    override public func setData(_ data: [String: Any]) {
        city = data["city"] as? String
        country = data["country"] as? String
        postcode = data["postcode"] as? String
        state = data["state"] as? String
        
        let ulCoordinates = ULCoordinates.shared() as! ULCoordinates
        ulCoordinates.setData(data["coordinates"] as! [String : Any])
        
        let ulStreet = ULStreet.shared() as! ULStreet
        ulStreet.setData(data["street"] as! [String : Any])
        
        let ulTimzone = ULTimezone.shared() as! ULTimezone
        ulTimzone.setData(data["timezone"] as! [String : Any])
        
        coordinates = ulCoordinates
        street = ulStreet
        timezone = ulTimzone
    }
}
