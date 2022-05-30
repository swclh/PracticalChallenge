//
//	Id.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Id : NSManagedObject{

	@NSManaged var result : User!
	@NSManaged var name : String!
	@NSManaged var value : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Id", in: context)!
        super.init(entity: entity, insertInto: context)
		if let resultData = dictionary["result"] as? [String:Any]{
			result = User(fromDictionary: resultData, context:context)
		}
		if let nameValue = dictionary["name"] as? String{
			name = nameValue
		}
		if let valueValue = dictionary["value"] as? String{
			value = valueValue
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
		if name != nil{
			dictionary["name"] = name
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

}
