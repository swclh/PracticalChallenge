//
//  userDataDecoderClass.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import Foundation

struct userDataDecoderClass : Decodable{
    var results : [results]
}

struct results : Decodable{
    var gender : String?
    var name: name?
    var dob: dob?
    var picture: picture?
    var email: String?
    var location: location?
}

struct name : Decodable{
    var  title: String?
    var first: String?
    var last: String?
}

struct dob : Decodable{
    var date: String?
    var age: Double?
}

struct picture : Decodable{
    var large: String?
    var medium: String?
    var thumbnail: String?
}

struct location: Decodable{
    var city: String?
    var state: String?
    var coordinates: coordinates?
    var timezone: timezone?
}

struct coordinates: Decodable {
    var latitude: String?
    var longitude: String?
}
struct timezone: Decodable {
    var offset: String?
    var description: String?
}
