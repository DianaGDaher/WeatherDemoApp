//
//  Api.swift
//  WeatherForecastTests
//
//  Created by Diana on 1/21/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class Api: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetCityWeather() {
        let expectNil = expectation(description: "Expect nil")
        apiManager.getCityWeather(cityName: "l") { (model, _) in
            if model == nil {
                expectNil.fulfill()
            }
        }
        let expectNotNil = expectation(description: "Expect Not nil")
        apiManager.getCityWeather(cityName: "london") { (model, _) in
            if model != nil {
                expectNotNil.fulfill()
            }
        }
        wait(for: [expectNil, expectNotNil], timeout: 30)
    }
    func testGetCityForeCast() {
        
        let expectNotNil = expectation(description: "Expect Not nil")
        apiManager.getCityForecast(longitude: 45, latitude: -75) { (model) in
            if model != nil {
                expectNotNil.fulfill()
            }
        }
        wait(for: [expectNotNil], timeout: 30)
    }

}
