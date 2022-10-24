//
//  UserPhotoFetch.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 24/10/22.
//

import UIKit

enum PhotoError: Error {
    case imageCreationError
    
    var errorDescription: String? {
        switch self {
        case .imageCreationError:
            return "Error creating image"
        }
    }
}

struct UserPhotoFetch {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchPhoto(photoURL: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
            
            // Coulfn't create an image
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
}
