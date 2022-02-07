//
//  DecimalUtilitiy.swift
//  Accounts
//
//  Created by Ben Garrison on 2/6/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
