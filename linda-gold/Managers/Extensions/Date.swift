//
//  Date.swift
//  linda-gold
//
//  Created by Chhun on 1/30/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

extension Date {
    func endDateToTodayUTC() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return calendar.date(from: components)!
    }
    // End Week
    func endOfWeekUTC() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: .weekday, value: 6, to: Date())!
    }
    // Fist month
    func startOfMonthUTC() -> Date {
           let calendar = Calendar.autoupdatingCurrent // Use autoupdating calendar for time zone handling
           return calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
       }
       // End month
       func endOfMonthUTC() -> Date {
           let calendar = Calendar.autoupdatingCurrent // Use autoupdating calendar for time zone handling
           let nextMonthComponents = DateComponents(month: 1, day: -1)
           return calendar.date(byAdding: nextMonthComponents, to: startOfMonthUTC())!
       }
    // Fist of Year
     func firstOfYearUTC() -> Date {
         let calendar = Calendar(identifier: .gregorian)
         let components = calendar.dateComponents([.year], from: Date())
         return calendar.date(from: components)!
     }
    // Last Of year
     func lastOfYearUTC() -> Date {
         let calendar = Calendar(identifier: .gregorian)
         var components = calendar.dateComponents([.year], from: Date())
//         components.year = components.year! - 1
         components.month = 12
         components.day = calendar.range(of: .day, in: .month, for: calendar.date(from: components)!)!.upperBound - 1
         return calendar.date(from: components)!
     }
    // Formatter to TimeUTC //Form: -> formattedUTC(with: "yyyy-MM-dd'T'HH:mm:ssZ")
    func formattedUTC(with format: String, timeZone: TimeZone = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func formatDate(_ formatString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: Date())
        }
}
