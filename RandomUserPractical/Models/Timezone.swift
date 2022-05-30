//
//	Timezone.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Timezone : NSManagedObject{

	@NSManaged var location : Location!
	@NSManaged var descriptionField : String!
	@NSManaged var offset : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Timezone", in: context)!
        super.init(entity: entity, insertInto: context)
		if let locationData = dictionary["location"] as? [String:Any]{
			location = Location(fromDictionary: locationData, context:context)
		}
		if let descriptionFieldValue = dictionary["description"] as? String{
			descriptionField = descriptionFieldValue
		}
		if let offsetValue = dictionary["offset"] as? String{
			offset = offsetValue
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
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if offset != nil{
			dictionary["offset"] = offset
		}
		return dictionary
	}

}
