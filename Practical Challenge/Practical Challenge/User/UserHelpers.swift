//
//  UserHelpers.swift
//  Practical Challenge
//
//  Created by Sophie Rofe on 24/10/22.
//

import UIKit

struct UserHelpers {
    
    private let dateFormatter = DateFormatter()
    private let userPhotoFetch = UserPhotoFetch()
    
    func formatBasicInfo(infoType: String, info: String) -> NSAttributedString {
        let infoString = NSAttributedString(string: info)
        let boldAtrribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let returnString = NSMutableAttributedString(string: infoType, attributes: boldAtrribute)
        returnString.append(infoString)
        return returnString
    }
    
    func formatDOB(dob: User.DateOfBirth) -> NSAttributedString {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var date = NSAttributedString(string: "\(dob.date)")
        let formattedDate = dateFormatter.date(from: dob.date)
        if let unwrappedDate = formattedDate {
            date = NSAttributedString(string: "\(unwrappedDate.formatted(date: .numeric, time: .omitted))")
        }
        
        let boldAtrribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let returnString = NSMutableAttributedString(string: "DOB: ", attributes: boldAtrribute)
        returnString.append(date)
        return returnString
    }
}
