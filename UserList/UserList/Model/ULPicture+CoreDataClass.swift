//
//  ULPicture+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULPicture)
public class ULPicture: ULManagedObject {
    override public func setData(_ data: [String : Any]) {
        large = data["large"] as? String
        medium = data["medium"] as? String
        thumbnail = data["thumbnail"] as? String
    }
}
