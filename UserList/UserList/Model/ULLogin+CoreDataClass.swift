//
//  ULLogin+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULLogin)
public class ULLogin: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        password = data["password"] as? String
        salt = data["salt"] as? String
        username = data["username"] as? String
        uuid = data["uuid"] as? String
    }
}
