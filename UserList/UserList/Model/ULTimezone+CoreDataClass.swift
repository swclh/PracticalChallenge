//
//  ULTimezone+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULTimezone)
public class ULTimezone: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        descriptions = data["description"] as? String
        offset = data["offset"] as? String
    }
    
    public func getTimezone() -> String {
        return ((offset ?? "") + " " + (descriptions ?? ""))
    }
}
