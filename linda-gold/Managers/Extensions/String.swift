//
//  String+Extension.swift
//  Core-MVVM
//
//  Created by Sovannra on 26/1/22.
//  Copyright © 2022 Core-MVVM. All rights reserved.
//

import UIKit

// MARK: - Compare Version
extension String {
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        
        var versionComponents = self.components(separatedBy: versionDelimiter) // <1>
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)
        
        let zeroDiff = versionComponents.count - otherVersionComponents.count // <2>
        
        if zeroDiff == 0 { // <3>
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff)) // <4>
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros) // <5>
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric) // <6>
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8, allowLossyConversion: true) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    func getWidth(size: CGFloat,weight: UIFont.Weight = .regular) -> CGFloat {
        return self.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: weight)
        ]).width
    }
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    enum DateFormat: String {
            case date = "MMM d yyyy"
            case date_time = "dd MMM yyyy, h:mm a"
            case time = "hh:mm a"
            case date_utc = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
    }
    func formatDate(formatString: DateFormat = .date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = formatString.rawValue
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            dateFormatter.locale = Locale(identifier: "en" == "en" ? "en_US" : "km_KH")
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func covertDateToUTC(dateFormat: String = "MMM dd, YYYY")-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.calendar = .init(identifier: .gregorian)
        if let convertedDate = formatter.date(from: self) {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return formatter.string(from: convertedDate)
        }
        return ""
    }
}

