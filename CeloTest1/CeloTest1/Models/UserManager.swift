//
//  UserManager.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 27/05/22.
//

import Foundation
import UIKit

class UserManager{
    
    //Defining Singleton for Shared use
    static var instance = UserManager()
    let db = DatabaseManager.shared
    
    //this Action runs the API and loads it to DB
    func performRequest(urlString: String, completionBlock: @escaping () -> Void)
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
                    self.ParseJSON(userData: safeData)
                    completionBlock()
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
            
            db.DeleteAll(objectType: User.self)
            
            for data in decodedData.results {
                
                let user = db.add(objectType: User.self)
                
                if let FirstName = data.name?.first, let LastName = data.name?.last,
                   let Gender = data.gender, let DOB = data.dob?.date,
                    let Thumbnail = data.picture?.thumbnail, let ProfilePic = data.picture?.large,
                        let email = data.email,
                   let city = data.location?.city,let title = data.name?.title{
                    
                    user?.name = FirstName+" "+LastName
                    user?.city = city
                    user?.gender = Gender
                    user?.thumbnail = Thumbnail
                    user?.dateOfBirth = String(DOB.prefix(10)).toDate()
                    user?.profilePicture = ProfilePic
                    user?.email = email
                    user?.title = title
        
                }
            }
            
            db.save()
           
        }
        catch{
            print(error)
            
        }
        
        
    }
    
    func DateToString(date: Date) -> String
    {
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YYYY/MM/dd"

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    func getImageByUrl(urlString: String, completionBlock: @escaping(Data)->Void)
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

//MARK: - String Extension

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
