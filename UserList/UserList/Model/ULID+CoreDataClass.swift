//
//  ULID+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULID)
public class ULID: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        name = data["name"] as? String
        value = data["value"] as? String
    }
}
