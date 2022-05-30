//
//	Dob.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Dob : NSManagedObject{

	@NSManaged var result : User!
	@NSManaged var age : Int
	@NSManaged var date : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Dob", in: context)!
		super.init(entity: entity, insertInto: context)
		if let resultData = dictionary["result"] as? [String:Any]{
			result = User(fromDictionary: resultData, context:context)
		}
		if let ageValue = dictionary["age"] as? Int{
			age = ageValue
		}
		if let dateValue = dictionary["date"] as? String{
			date = dateValue
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
		dictionary["age"] = age
		if date != nil{
			dictionary["date"] = date
		}
		return dictionary
	}

}
