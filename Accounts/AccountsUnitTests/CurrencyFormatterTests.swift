//
//  CurrencyConversionTests.swift
//  AccountsUnitTests
//
//  Created by Ben Garrison on 2/7/22.
//

import Foundation
import XCTest

@testable import Accounts

class Test: XCTestCase {
    
    var currencyFormatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        currencyFormatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = currencyFormatter.breakIntoDollarsAndCents(55555.55)
        XCTAssertEqual(result.0, "55,555")
        XCTAssertEqual(result.1, "55")
    }
    
    func testDollarsFormatted() throws {
        let result = currencyFormatter.dollarsFormatted(55555.55)
        XCTAssertEqual(result, "$55,555.55")
    }
    
    func testZeroDollarsFormatted() {
        let result = currencyFormatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
        //XCTAssertEqual(result, "0")
    }
    
    
}

