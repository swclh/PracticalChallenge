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
    let picture: Dictionary<String, URL>
    var name: Dictionary<String, String>
    
    struct DateOfBirth: Codable {
        var date: String
        var age: Int
    }
}
