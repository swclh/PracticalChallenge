//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class UserList : NSManagedObject{

	@NSManaged var info : Info!
    @NSManaged var results : Array<User>!
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "UserList", in: context)!
        super.init(entity: entity, insertInto: context)
		if let infoData = dictionary["info"] as? [String:Any]{
			info = Info(fromDictionary: infoData, context:context)
		}
		if let resultsArray = dictionary["results"] as? [[String:Any]]{
            
			for dic in resultsArray{
				let value = User(fromDictionary: dic, context:context)
                results.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if info != nil{
			dictionary["info"] = info.toDictionary()
		}
		if results != nil{
			var dictionaryElements = [[String:Any]]()
			for resultsElement in results {
                print(resultsElement)
                dictionaryElements.append((resultsElement).toDictionary())
			}
			dictionary["results"] = dictionaryElements
		}
		return dictionary
	}

}
