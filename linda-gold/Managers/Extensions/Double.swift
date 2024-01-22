//
//  Double.swift
//  linda-gold
//
//  Created by Chhun on 1/21/24.
//  Copyright © 2024 Core-MVVM. All rights reserved.
//

import Foundation

extension Double{
    var formatCurrencyNumber: String {
        var currency = "\(self)"
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.currencySymbol = "$"
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            currency = formattedString
        }
        return "\(currency)"
    }
    
    var formatCurrencyNumberK: String {
        if self >= 1000, self <= 999999 {
            return String(format: "$%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999 {
            return String(format: "$%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        return String(format: "$%.2f", locale: Locale.current,self)
        
    }
}
