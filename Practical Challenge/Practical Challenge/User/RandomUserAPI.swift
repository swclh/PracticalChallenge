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
        return randomUserURL(endPoint: .baseURLString, parameters: [
            "results" : "100"
        ])
    }
    
    private static func randomUserURL(endPoint: EndPoint, parameters: [String: String]?) -> URL? {
        var components = URLComponents(string: endPoint.rawValue)!
        var queryItems = [URLQueryItem]()
        
        if let additionalParams = parameters{
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url
    }
}
