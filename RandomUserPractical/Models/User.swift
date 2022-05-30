//
//	Result.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class User : NSManagedObject{

	@NSManaged var rootClass : UserList!
	@NSManaged var cell : String!
	@NSManaged var dob : Dob!
	@NSManaged var email : String!
	@NSManaged var gender : String!
	@NSManaged var id : Id!
	@NSManaged var location : Location!
	@NSManaged var login : Login!
	@NSManaged var name : Name!
	@NSManaged var nat : String!
	@NSManaged var phone : String!
	@NSManaged var picture : Picture!
	@NSManaged var registered : Dob!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName: "Result", in: context)!
        super.init(entity: entity, insertInto: context)
		if let rootClassData = dictionary["rootClass"] as? [String:Any]{
			rootClass = UserList(fromDictionary: rootClassData, context:context)
		}
		if let cellValue = dictionary["cell"] as? String{
			cell = cellValue
		}
		if let dobData = dictionary["dob"] as? [String:Any]{
			dob = Dob(fromDictionary: dobData, context:context)
		}
		if let emailValue = dictionary["email"] as? String{
			email = emailValue
		}
		if let genderValue = dictionary["gender"] as? String{
			gender = genderValue
		}
		if let idData = dictionary["id"] as? [String:Any]{
			id = Id(fromDictionary: idData, context:context)
		}
		if let locationData = dictionary["location"] as? [String:Any]{
			location = Location(fromDictionary: locationData, context:context)
		}
		if let loginData = dictionary["login"] as? [String:Any]{
			login = Login(fromDictionary: loginData, context:context)
		}
		if let nameData = dictionary["name"] as? [String:Any]{
			name = Name(fromDictionary: nameData, context:context)
		}
		if let natValue = dictionary["nat"] as? String{
			nat = natValue
		}
		if let phoneValue = dictionary["phone"] as? String{
			phone = phoneValue
		}
		if let pictureData = dictionary["picture"] as? [String:Any]{
			picture = Picture(fromDictionary: pictureData, context:context)
		}
		if let registeredData = dictionary["registered"] as? [String:Any]{
			registered = Dob(fromDictionary: registeredData, context:context)
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
		if cell != nil{
			dictionary["cell"] = cell
		}
		if dob != nil{
			dictionary["dob"] = dob.toDictionary()
		}
		if email != nil{
			dictionary["email"] = email
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if id != nil{
			dictionary["id"] = id.toDictionary()
		}
		if location != nil{
			dictionary["location"] = location.toDictionary()
		}
		if login != nil{
			dictionary["login"] = login.toDictionary()
		}
		if name != nil{
			dictionary["name"] = name.toDictionary()
		}
		if nat != nil{
			dictionary["nat"] = nat
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if picture != nil{
			dictionary["picture"] = picture.toDictionary()
		}
		if registered != nil{
			dictionary["registered"] = registered.toDictionary()
		}
		return dictionary
	}

}
