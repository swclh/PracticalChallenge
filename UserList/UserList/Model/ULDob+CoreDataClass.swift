//
//  ULDob+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULDob)
public class ULDob: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        age = data["age"] as! Int64
        date = data["date"] as? String
    }
}
