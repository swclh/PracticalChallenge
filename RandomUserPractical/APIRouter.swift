//
//  APIRouter.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation

struct APIRouter {
    var numberOfUsersPerList = 10
    var page = 1
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "randomuser.me"
        components.path = "/api/"
        components.queryItems = [
            URLQueryItem(name: "results", value: String(numberOfUsersPerList)),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        return components.url
    }
    
    func callApi() throws -> URLRequest {
        guard let route = url else {
            throw ApiError.invalidRoute
        }
        
        return URLRequest(url: route)
    }
}

enum ApiError: Error {
    case invalidRoute
    case emptyResponse
}
