//
//  ULUser+CoreDataClass.swift
//  
//
//  Created by Yanqi Zhao on 24/11/22.
//
//

import Foundation
import CoreData

@objc(ULUser)
public class ULUser: ULManagedObject {
    @discardableResult public class func configure() -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.classString)
        let sortDes0 = NSSortDescriptor(key: "page", ascending: true)
        let sortDes1 = NSSortDescriptor(key: "name.firstName", ascending: true)
        request.sortDescriptors = [sortDes0, sortDes1]
        request.fetchOffset = 0
        request.fetchLimit = count_per_page
        return request
    }
    
    override public func setData(_ data: [String : Any]) {
        cell = data["cell"] as? String
        email = data["email"] as? String
        gender = data["gender"] as? String
        nat = data["nat"] as? String
        page = Int64(UserDefaults.cachedPage)
        phone = data["phone"] as? String
    }
    
    public class func appendArray(array: [[String: Any]]) {
        for data in array {
            append(data: data)
        }
        shared_application_delegate.saveContext()
    }
    
    private class func append(data:[String: Any]) {
        let user = ULUser.shared() as! ULUser
        
        let dob = ULDob.shared() as! ULDob
        dob.setData(data["dob"] as! [String : Any])
        
        let location = ULLocation.shared() as! ULLocation
        location.setData(data["location"] as! [String : Any])
        
        let login = ULLogin.shared() as! ULLogin
        login.setData(data["login"] as! [String : Any])
        
        let name = ULName.shared() as! ULName
        name.setData(data["name"] as! [String : Any])
        
        let picture = ULPicture.shared() as! ULPicture
        picture.setData(data["picture"] as! [String : Any])
        
        let registered = ULRegistered.shared() as! ULRegistered
        registered.setData(data["registered"] as! [String : Any])
        
        let id = ULID.shared() as! ULID
        id.setData(data["id"] as! [String : Any])
        
        user.dob = dob
        user.location = location
        user.login = login
        user.name = name
        user.picture = picture
        user.registered = registered
        user.id = id
        
        user.setData(data)
    }
}
