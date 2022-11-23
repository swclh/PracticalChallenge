//
//  ULManagedObject.swift
//  UserList
//
//  Created by Yanqi Zhao on 24/11/22.
//

import CoreData

public class ULManagedObject: NSManagedObject {
    public static func shared() -> ULManagedObject {
        let entityDescription = NSEntityDescription.entity(forEntityName: self.classString, in: core_data_context)
        return ULManagedObject(entity: entityDescription!, insertInto: core_data_context)
    }
    
    func setData(_ data:[String: Any]) {
        assert(false, "setData must be overrided by subclass!")
    }
}
