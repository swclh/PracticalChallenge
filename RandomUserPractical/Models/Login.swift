//
//	Login.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Login : NSManagedObject{

	@NSManaged var result : User!
	@NSManaged var md5 : String!
	@NSManaged var password : String!
	@NSManaged var salt : String!
	@NSManaged var sha1 : String!
	@NSManaged var sha256 : String!
	@NSManaged var username : String!
	@NSManaged var uuid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Login", in: context)!
        super.init(entity: entity, insertInto: context)
		if let resultData = dictionary["result"] as? [String:Any]{
			result = User(fromDictionary: resultData, context:context)
		}
		if let md5Value = dictionary["md5"] as? String{
			md5 = md5Value
		}
		if let passwordValue = dictionary["password"] as? String{
			password = passwordValue
		}
		if let saltValue = dictionary["salt"] as? String{
			salt = saltValue
		}
		if let sha1Value = dictionary["sha1"] as? String{
			sha1 = sha1Value
		}
		if let sha256Value = dictionary["sha256"] as? String{
			sha256 = sha256Value
		}
		if let usernameValue = dictionary["username"] as? String{
			username = usernameValue
		}
		if let uuidValue = dictionary["uuid"] as? String{
			uuid = uuidValue
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if result != nil{
			dictionary["result"] = result.toDictionary()
		}
		if md5 != nil{
			dictionary["md5"] = md5
		}
		if password != nil{
			dictionary["password"] = password
		}
		if salt != nil{
			dictionary["salt"] = salt
		}
		if sha1 != nil{
			dictionary["sha1"] = sha1
		}
		if sha256 != nil{
			dictionary["sha256"] = sha256
		}
		if username != nil{
			dictionary["username"] = username
		}
		if uuid != nil{
			dictionary["uuid"] = uuid
		}
		return dictionary
	}

}
