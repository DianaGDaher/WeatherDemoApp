//
//  SearchViewModel_Test.swift
//  Weather ForecastTests
//
//  Created by Diana on 1/20/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class SearchViewModel_Test: XCTestCase {
    var viewModel: SearchViewModel?
    override func setUp() {
        viewModel = SearchViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    func testCheckValidEnry () {
        XCTAssertTrue(self.viewModel?.checkValidEntry(txtFieldText: "London, Paris, New York", newInput: ",") ?? false)
        XCTAssertTrue(self.viewModel?.checkValidEntry(txtFieldText: "London, Paris, New York,", newInput: "D") ?? false)
        XCTAssertTrue(self.viewModel?.checkValidEntry(txtFieldText: "London, Paris, New York, Dubai, Beirut, Hong Kong, Berlin", newInput: " ") ?? false)
        XCTAssertFalse(self.viewModel?.checkValidEntry(txtFieldText: "London, Paris, New York, Dubai, Beirut, Hong Kong, Berlin", newInput: ",") ?? false)
    }
    
}
