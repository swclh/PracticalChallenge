//
//  User.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 22/10/22.
//

import UIKit

struct User: Codable {
    let gender: String
    let dob: DateOfBirth
    let picture: Pictures
    var name: Name
    
    struct DateOfBirth: Codable {
        var date: String
        var age: Int
    }
    
    struct Name: Codable {
        var title: String
        var last: String
        var first: String
    }
    
    struct Pictures: Codable {
        var thumbnail: URL
        var large: URL
        var medium: URL
    }
}
