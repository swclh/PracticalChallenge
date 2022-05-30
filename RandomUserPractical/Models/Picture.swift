//
//	Picture.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Picture : NSManagedObject{

	@NSManaged var result : User!
	@NSManaged var large : String!
	@NSManaged var medium : String!
	@NSManaged var thumbnail : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Picture", in: context)!
        super.init(entity: entity, insertInto: context)
		if let resultData = dictionary["result"] as? [String:Any]{
			result = User(fromDictionary: resultData, context:context)
		}
		if let largeValue = dictionary["large"] as? String{
			large = largeValue
		}
		if let mediumValue = dictionary["medium"] as? String{
			medium = mediumValue
		}
		if let thumbnailValue = dictionary["thumbnail"] as? String{
			thumbnail = thumbnailValue
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
		if large != nil{
			dictionary["large"] = large
		}
		if medium != nil{
			dictionary["medium"] = medium
		}
		if thumbnail != nil{
			dictionary["thumbnail"] = thumbnail
		}
		return dictionary
	}

}
