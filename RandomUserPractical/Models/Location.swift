//
//	Location.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Location : NSManagedObject{

	@NSManaged var result : User!
	@NSManaged var city : String!
	@NSManaged var coordinates : Coordinate!
	@NSManaged var country : String!
	@NSManaged var postcode : String!
	@NSManaged var state : String!
	@NSManaged var street : Street!
	@NSManaged var timezone : Timezone!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: context)!
        super.init(entity: entity, insertInto: context)
		if let resultData = dictionary["result"] as? [String:Any]{
			result = User(fromDictionary: resultData, context:context)
		}
		if let cityValue = dictionary["city"] as? String{
			city = cityValue
		}
		if let coordinatesData = dictionary["coordinates"] as? [String:Any]{
			coordinates = Coordinate(fromDictionary: coordinatesData, context:context)
		}
		if let countryValue = dictionary["country"] as? String{
			country = countryValue
		}
		if let postcodeValue = dictionary["postcode"] as? String{
			postcode = postcodeValue
		}
		if let stateValue = dictionary["state"] as? String{
			state = stateValue
		}
		if let streetData = dictionary["street"] as? [String:Any]{
			street = Street(fromDictionary: streetData, context:context)
		}
		if let timezoneData = dictionary["timezone"] as? [String:Any]{
			timezone = Timezone(fromDictionary: timezoneData, context:context)
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
		if city != nil{
			dictionary["city"] = city
		}
		if coordinates != nil{
			dictionary["coordinates"] = coordinates.toDictionary()
		}
		if country != nil{
			dictionary["country"] = country
		}
		if postcode != nil{
			dictionary["postcode"] = postcode
		}
		if state != nil{
			dictionary["state"] = state
		}
		if street != nil{
			dictionary["street"] = street.toDictionary()
		}
		if timezone != nil{
			dictionary["timezone"] = timezone.toDictionary()
		}
		return dictionary
	}

}
