//
//	Street.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Street : NSManagedObject{

	@NSManaged var location : Location!
	@NSManaged var name : String!
	@NSManaged var number : Int


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Street", in: context)!
        super.init(entity: entity, insertInto: context)
		if let locationData = dictionary["location"] as? [String:Any]{
			location = Location(fromDictionary: locationData, context:context)
		}
		if let nameValue = dictionary["name"] as? String{
			name = nameValue
		}
		if let numberValue = dictionary["number"] as? Int{
			number = numberValue
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if location != nil{
			dictionary["location"] = location.toDictionary()
		}
		if name != nil{
			dictionary["name"] = name
		}
		dictionary["number"] = number
		return dictionary
	}

}
