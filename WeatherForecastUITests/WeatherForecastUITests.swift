//
//  Weather_ForecastUITests.swift
//  Weather ForecastUITests
//
//  Created by Diana on 1/20/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import XCTest

class Weather_ForecastUITests: XCTestCase {
    
    var citiesFound: XCTestExpectation!
    var alertShown: XCTestExpectation!
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func writeWord(_ word: String) {
        word.forEach { (char) in
            tapKey(String(char.lowercased()))
        }
    }
    
    func tapKey(_ key: String) {
        app.keys[key].tap()
    }
    
    func test2Cities() {
        // UI tests must launch the application that they test.
        
        alertShown = expectation(description: "Alert Shown")
        app.launch()
        
        app.buttons["Other Cities"].tap()
        app.textFields["eg. london, paris, new york"].tap()
        
        writeWord("Beirut")
        tapKey("more")
        tapKey(",")
        tapKey("space")
        writeWord("London")
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        perform(#selector(fulfillTests), with: nil, afterDelay: 1)
        
        wait(for: [alertShown], timeout: 2)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }

    func test3Cities() {
        // UI tests must launch the application that they test.
        
        citiesFound = expectation(description: "3 cities found")
        app.launch()
        
        app.buttons["Other Cities"].tap()
        app.textFields["eg. london, paris, new york"].tap()
        
        writeWord("Beirut")
        tapKey("more")
        tapKey(",")
        tapKey("space")
        writeWord("London")
        tapKey("more")
        tapKey(",")
        tapKey("space")
        writeWord("Dubai")
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        perform(#selector(fulfillTests), with: nil, afterDelay: 5)
        
        wait(for: [citiesFound], timeout: 30)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    @objc func fulfillTests() {
        if app.tables.cells.count == 3 {
            citiesFound.fulfill()
        }
        if app.alerts["Missing cities"].exists {
            alertShown.fulfill()
        }
    }

}
