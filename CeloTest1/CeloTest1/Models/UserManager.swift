//
//  UserManager.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import Foundation
import UIKit

class UserManager{
    
    static var instance = UserManager()
    
    func performRequest(urlString: String, completionBlock: @escaping ([User]) -> Void)
    {
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            
            if(error != nil){
                print(error!.localizedDescription)
            }
            else
            {
                if let safeData = data{
                    print("From model \(safeData)")
                    completionBlock(self.ParseJSON(userData: safeData))
                }
            }
        }
        
        task.resume()
    
    }
    
    func ParseJSON(userData : Data) -> [User]
    {
        let decoder = JSONDecoder()
        var users = [User]()
        
        do{
            let decodedData = try decoder.decode(userDataDecoderClass.self, from: userData)
            
            for data in decodedData.results {
                let user = User()
                
                if let FirstName = data.name?.first, let LastName = data.name?.last,
                   let Gender = data.gender, let DOB = data.dob?.date,
                    let Thumbnail = data.picture?.thumbnail, let ProfilePic = data.picture?.large,
                        let email = data.email,
                   let city = data.location?.city,let title = data.name?.title{
                    
                    user.Name = FirstName+" "+LastName
                    user.City = city
                    user.Gender = Gender
                    UserManager.getImageByUrl(urlString: Thumbnail, completionBlock: { data in
                        user.Thumbnail = data
                    })
                    user.DateOfBirth = String(DOB.prefix(10)).toDate()
                    UserManager.getImageByUrl(urlString: ProfilePic, completionBlock: { data in
                        user.ProfilePicture = data
                    })
                    user.Email = email
                    user.title = title
                    
                    users.append(user)
                    
                }
            }
            
            return users
        }
        catch{
            print(error)
            return users
        }
        
        
    }
    
    static func DateToString(date: Date) -> String
    {
        
        
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY/MM/dd"

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    static func getImageByUrl(urlString: String, completionBlock: @escaping(Data)->Void)
    {
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            
            if(error != nil){
                print(error!.localizedDescription)
            }
            else
            {
                if let safeData = data{
                    completionBlock(safeData)
                }
            }
        }
        
        task.resume()
    }
    
}

// MARK :- String Extension
extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
