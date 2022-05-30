//
//	Info.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Info : NSManagedObject{

	@NSManaged var rootClass : UserList!
	@NSManaged var page : Int
	@NSManaged var results : Int
	@NSManaged var seed : String!
	@NSManaged var version : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Info", in: context)!
        super.init(entity: entity, insertInto: context)
		if let rootClassData = dictionary["rootClass"] as? [String:Any]{
			rootClass = UserList(fromDictionary: rootClassData, context:context)
		}
		if let pageValue = dictionary["page"] as? Int{
			page = pageValue
		}
		if let resultsValue = dictionary["results"] as? Int{
			results = resultsValue
		}
		if let seedValue = dictionary["seed"] as? String{
			seed = seedValue
		}
		if let versionValue = dictionary["version"] as? String{
			version = versionValue
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if rootClass != nil{
			dictionary["rootClass"] = rootClass.toDictionary()
		}
		dictionary["page"] = page
		dictionary["results"] = results
		if seed != nil{
			dictionary["seed"] = seed
		}
		if version != nil{
			dictionary["version"] = version
		}
		return dictionary
	}

}
