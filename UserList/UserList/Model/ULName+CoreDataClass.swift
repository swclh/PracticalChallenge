//
//  ULName+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULName)
public class ULName: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        firstName = data["first"] as? String
        lastName = data["last"] as? String
        title = data["title"] as? String
    }
    
    public func getTitleName() -> String {
        return (title ?? "") + " " + (firstName ?? "") + " " + (lastName ?? "")
    }
    
    public func getFullName() -> String {
        return (firstName ?? "") + " " + (lastName ?? "")
    }
}
