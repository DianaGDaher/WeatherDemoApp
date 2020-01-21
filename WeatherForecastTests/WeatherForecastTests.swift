//
//  Weather_ForecastTests.swift
//  Weather ForecastTests
//
//  Created by Diana on 1/20/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class Weather_ForecastTests: XCTestCase {
    var viewModel: LocalWeatherViewModel?

    override func setUp() {
        viewModel = LocalWeatherViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testExample() {
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
