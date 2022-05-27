//
//  UserManager.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import Foundation

class UserManager{
    
    let baseUrl = "https://randomuser.me/api/?results=20"
    
    static var instance = UserManager()
    
    func performRequest()
    {
        let url = URL(string: baseUrl)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            
            if(error != nil){
                print(error!.localizedDescription)
            }
            else
            {
                if let safeData = data{
                    print("From model \(safeData)")
                    self.ParseJSON(userData: safeData)
                }
            }
            
        }
        
        task.resume()
    }
    
    func ParseJSON(userData : Data)
    {
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(userDataDecoderClass.self, from: userData)
            print(decodedData.results[0])
        }
        catch{
            print(error)
        }
    }
}
