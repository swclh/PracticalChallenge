//
//	Coordinate.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Coordinate : NSManagedObject{

	@NSManaged var location : Location!
	@NSManaged var latitude : String!
	@NSManaged var longitude : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Coordinate", in: context)!
		super.init(entity: entity, insertInto: context)
		if let locationData = dictionary["location"] as? [String:Any]{
			location = Location(fromDictionary: locationData, context:context)
		}
		if let latitudeValue = dictionary["latitude"] as? String{
			latitude = latitudeValue
		}
		if let longitudeValue = dictionary["longitude"] as? String{
			longitude = longitudeValue
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
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		return dictionary
	}

}
