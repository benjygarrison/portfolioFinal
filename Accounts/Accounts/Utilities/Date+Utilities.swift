//
//  Date+Utilities.swift
//  Accounts
//
//  Created by Ben Garrison on 2/9/22.
//

import Foundation

extension Date {
    static var accountsFormattedDate: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "MDT")
        return dateFormatter
    }
    
    var monthDayYear: String {
        let dateFormatter = Date.accountsFormattedDate
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
