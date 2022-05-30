//
//  DateUtils.swift
//  RandomUserPractical
//
//  Created by Paresh Kacha on 30/05/22.
//

import Foundation
class DateUtils {
    
    private static let parsingFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    private static let dobFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    static func parse(_ date: String?) -> Date? {
        guard let date = date else {
            return nil
        }
        return parsingFormatter.date(from: date)
    }

    static func formatDob(_ date: Date) -> String {
        return dobFormatter.string(from: date)
    }
}
