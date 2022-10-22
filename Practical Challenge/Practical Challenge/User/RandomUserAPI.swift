//
//  RandomUserAPI.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 19/10/22.
//

import Foundation

// Allow for other endpoints to be added in the future
enum EndPoint: String {
    case baseURLString = "https://randomuser.me/api/"
}

enum RandomUserAPI {
    
    // Have a func for each URL option for future proofing new features
    static func baseUserUrl() -> URL? {
        return randomUserURL(endPoint: .baseURLString)
    }
    
    private static func randomUserURL(endPoint: EndPoint) -> URL? {
        var components = URLComponents(string: endPoint.rawValue)!
        return components.url
    }
}
