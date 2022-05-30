//
//  ULEntity.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation

// MARK: - Welcome
struct ULEntity: Codable {
    var results: [User]
    var info: Info
}

// MARK: - Info
struct Info: Codable {
    private(set) var seed: String?
    private(set) var results, page: Int
    private(set) var version: String?
}

// MARK: - Result
struct User: Codable {
    private(set) var gender: String?
    private(set) var name: Name
    private(set) var location: Location
    private(set) var email: String?
    private(set) var login: Login
    private(set) var dob, registered: Dob
    private(set) var phone, cell: String?
    private(set) var id: ID
    private(set) var picture: Picture
    private(set) var nat: String?
}

// MARK: - Dob
struct Dob: Codable {
    private(set) var date: String?
    private(set) var age: Int
}

// MARK: - ID
struct ID: Codable {
    private(set) var name, value: String?
}

// MARK: - Location
struct Location: Codable {
    private(set) var street: Street
    private(set) var city, state, country : String?
    private(set) var coordinates: Coordinates
    private(set) var timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable {
    private(set) var latitude, longitude: String?
}

// MARK: - Street
struct Street: Codable {
    private(set) var number: Int
    private(set) var name: String?
}

// MARK: - Timezone
struct Timezone: Codable {
    private(set) var offset, timezoneDescription: String?

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable {
    private(set) var uuid, username, password, salt: String?
    private(set) var md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable {
    private(set) var title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable {
    private(set) var large, medium, thumbnail: String?
}
