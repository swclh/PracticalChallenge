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
    
    func formatUserName(userName: User.Name) -> String {
        let userNameFormatted = "\(userName.title) \(userName.first) \(userName.last)"
        return "Name: \(userNameFormatted)"
    }
    
    func formatGender(gender: String) -> String {
        return "Gender: \(gender.uppercased())"
    }
    
    func formatDOB(dob: User.DateOfBirth) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let formattedDate = dateFormatter.date(from: dob.date)
        if let unwrappedDate = formattedDate {
            return "DOB: \(unwrappedDate.formatted(date: .numeric, time: .omitted))"
        } else {
            return "DOB: \(dob.date)"
        }
    }
}
