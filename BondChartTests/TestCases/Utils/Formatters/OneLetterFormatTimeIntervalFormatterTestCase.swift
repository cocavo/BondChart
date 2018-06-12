//
//  OneLetterFormatTimeIntervalFormatterTests.swift
//  BondChartTests
//
//  Created by Dmitry Tuhtamanov on 12/06/2018.
//  Copyright © 2018 tuhtamanov. All rights reserved.
//

import XCTest

class OneLetterFormatTimeIntervalFormatterTestCase: XCTestCase {
    private var sut: OneLetterFormatTimeIntervalFormatter!

    override func setUp() {
        super.setUp()
        sut = OneLetterFormatTimeIntervalFormatter()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

extension OneLetterFormatTimeIntervalFormatterTestCase {
    func test_stringForWeekInterval_returns_1W() {
        XCTAssertTrue(sut.string(for: .week) == "1W")
    }

    func test_stringForMonthInterval_returns_1M() {
        XCTAssertTrue(sut.string(for: .month) == "1M")
    }

    func test_stringForThreeMonthInterval_returns_3M() {
        XCTAssertTrue(sut.string(for: 3 * .month) == "3M")
    }

    func test_stringForSixMonthInterval_returns_6M() {
        XCTAssertTrue(sut.string(for: 6 * .month) == "6M")
    }

    func test_stringForYearInterval_returns_1Y() {
        XCTAssertTrue(sut.string(for: .year) == "1Y")
    }

    func test_stringForTwoYearInterval_returns_2Y() {
        XCTAssertTrue(sut.string(for: 2 * .year) == "2Y")
    }
}
