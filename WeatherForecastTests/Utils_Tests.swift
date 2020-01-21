//
//  Utils_Tests.swift
//  Weather ForecastTests
//
//  Created by Diana on 1/20/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class Utils_Tests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStringFromDate() {
        let now = Date.dateFrom(day: 20, month: 1, year: 2020) ?? Date()
        let result = Utils.stringFromDate(now)
        XCTAssertEqual(result, "2020-01-20")
    }
    
    func testStripTime() {
        let dateTime = Date.dateFrom(day: 20, month: 1, year: 2020, hour: 12, minute: 10, second: 30) ?? Date()
        let result = Utils.stripTime(from: dateTime)
        let resultStr = Utils.stringFromDate(result)
        XCTAssertEqual(resultStr, "2020-01-20")
    }
    
    func testStringFromTimeInterval() {
        let time = TimeInterval(1579478400)
        let result = Utils.stringFromTimeInterval(time)
        XCTAssertEqual(result, "2020-01-20")
    }
    
    func testTimeStringFromTimeInterval() {
        let time = TimeInterval(1579478400)
        let result = Utils.timeStringFromTimeInterval(time)
        XCTAssertEqual(result, "02:00am")
    }
    func testStripTimefromTimeInterval() {
        let time = TimeInterval(1579497610)
        let result = Utils.stripTimefromTimeInterval(time)
        let resultStr = Utils.stringFromDate(result)
        XCTAssertEqual(resultStr, "2020-01-20")
    }
    func testCapitalizeFirstLetter() {
        XCTAssertNotEqual("test".capitalizingFirstLetter(), "test")
        XCTAssertEqual("test".capitalizingFirstLetter(), "Test")
    }
    
}
