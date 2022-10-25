//
//  UserStore.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 22/10/22.
//

import UIKit

enum UserAPIError: LocalizedError {
    
    case noUsersFetched
    case urlError
    case unexpectedError
    
    var errorDescription: String? {
        switch self {
        case .noUsersFetched:
            return "No Users were able to be fetched"
        case .urlError:
            return "Something went wrong when building the url"
        case .unexpectedError:
            return "Unexpected error with the request"
        }
    }
}

final class UserStore {
    var users = [User]()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // MARK: - User fetch and process
    // Called fro the view controller, carried out API request
    func fetchUsers(pagination: Bool, currentPage: Int, completion: @escaping (Result<[User], Error>) -> Void){
        
        var seed = "abc"
        
        // If not paginating generate a new seed
        if !pagination{
            let characters = "abcdefghijklmnopqrstuvwxyz"
            seed = String(Array(0...2).map {_ in characters.randomElement()! })
        }
        
        // First check the url has been formed without error
        guard let url = RandomUserAPI.baseUserUrl(currentPage: currentPage, seed: seed) else {
            OperationQueue.main.addOperation {
                completion(.failure(UserAPIError.urlError))
            }
            return
        }

        // Make the request
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            // Check for possible errors
            if let requestError = error {
                OperationQueue.main.addOperation {
                    completion(.failure(requestError))
                }
                return
            }
            guard let jsonData = data else{
                OperationQueue.main.addOperation {
                    completion(.failure(UserAPIError.noUsersFetched))
                }
                return
            }

            // If no errors and data exists process the data
            let result = self.processUsers(fromJson: jsonData)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processUsers(fromJson data: Data) -> Result<[User], Error> {
        do {
            let decoder = JSONDecoder()
            
            let userResponse = try decoder.decode(UserResponse.self, from: data)
            return .success(userResponse.users)
        } catch {
            return .failure(error)
        }
    }
}

// Codable protocol
struct UserResponse: Codable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}
