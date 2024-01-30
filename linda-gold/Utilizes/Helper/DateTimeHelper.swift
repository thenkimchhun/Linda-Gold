//
//  DateTimeHelper.swift
//  linda-gold
//
//  Created by Chhun on 1/30/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

class DateTimeHelper{
    
    
    
    static func convertCurrentToUTC() -> String? {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Convert to UTC time
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        let utcDate = calendar.date(bySettingHour: 07, minute: 00 , second: 00, of: currentDate, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .forward)
        let utcOffset = utcTimeZone?.secondsFromGMT(for: utcDate ?? currentDate)
        let utcTime = utcDate?.addingTimeInterval(TimeInterval(utcOffset ?? 0))
        
        // Format the converted UTC time as a string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = utcTimeZone
        let utcTimeString = dateFormatter.string(from: utcTime ?? currentDate)
        
        return utcTimeString
    }
    
    static func getFirstAndLastDayOfWeek() -> (String, String) {
        let date = Date()
        // Get the current calendar
        let calendar = Calendar.current
        
        // Get the start of the week
        let week = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        let startOfWeek = calendar.date(byAdding: .day, value: 1, to: week!)
        // Get the end of the week
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: week!)
        
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        // Format the start and end of the week
        let startOfWeekFormatted = dateFormatter.string(from: startOfWeek!)
        let endOfWeekFormatted = dateFormatter.string(from: endOfWeek!)
        
        return (startOfWeekFormatted, endOfWeekFormatted)
    }
    
    
    static func getFirstAndLastDayOfMonth() -> (String, String) {
        let date = Date()
        // Get the current calendar
        let calendar = Calendar.current
        
        // Get the components for the input date
        let components = calendar.dateComponents([.year, .month], from: date)
        
        // Get the first day of the month
        let firstDayComponents = DateComponents(year: components.year, month: components.month, day: 1)
        guard let firstDayOfMonth = calendar.date(from: firstDayComponents) else {
            fatalError("Failed to get the first day of the month.")
        }
        
        // Get the last day of the month
        guard let range = calendar.range(of: .day, in: .month, for: date),
              let lastDay = range.last else {
            fatalError("Failed to get the last day of the month.")
        }
        
        let lastDayComponents = DateComponents(year: components.year, month: components.month, day: lastDay)
        guard let lastDayOfMonth = calendar.date(from: lastDayComponents) else {
            fatalError("Failed to get the last day of the month.")
        }
        
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        // Format the first day of the month
        let firstDayFormatted = dateFormatter.string(from: firstDayOfMonth)
        
        // Format the last day of the month
        let lastDayFormatted = dateFormatter.string(from: lastDayOfMonth)
        
        return (firstDayFormatted, lastDayFormatted)
    }
    
    
    static func getFirstAndLastDayOfYear() -> (String, String) {
        let date = Date()
        // Get the current calendar
        let calendar = Calendar.current
        
        // Get the start of the year
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: date))
        
        // Create components for the first day of the next year
        var components = DateComponents()
        components.year = 1
        components.day = -1
        
        // Get the end of the year
        let endOfYear = calendar.date(byAdding: components, to: startOfYear!)
        
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        // Format the start and end of the year
        let startOfYearFormatted = dateFormatter.string(from: startOfYear!)
        let endOfYearFormatted = dateFormatter.string(from: endOfYear!)
        
        return (startOfYearFormatted, endOfYearFormatted)
    }
}
