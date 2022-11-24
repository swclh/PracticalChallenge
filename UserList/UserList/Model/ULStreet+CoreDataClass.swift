//
//  ULStreet+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULStreet)
public class ULStreet: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        name = data["name"] as? String
        number = data["number"] as? Int64 ?? 0
    }
    
    public func getStreet() -> String {
        return (String(number) + " " + (name ?? ""))
    }
}
