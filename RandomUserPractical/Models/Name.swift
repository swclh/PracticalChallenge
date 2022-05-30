//
//	Name.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Name : NSManagedObject{

	@NSManaged var result : User!
	@NSManaged var first : String!
	@NSManaged var last : String!
	@NSManaged var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Name", in: context)!
        super.init(entity: entity, insertInto: context)
		if let resultData = dictionary["result"] as? [String:Any]{
			result = User(fromDictionary: resultData, context:context)
		}
		if let firstValue = dictionary["first"] as? String{
			first = firstValue
		}
		if let lastValue = dictionary["last"] as? String{
			last = lastValue
		}
		if let titleValue = dictionary["title"] as? String{
			title = titleValue
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
		if first != nil{
			dictionary["first"] = first
		}
		if last != nil{
			dictionary["last"] = last
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

}
