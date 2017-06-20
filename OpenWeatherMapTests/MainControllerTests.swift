//
//  OpenWeatherMapTests.swift
//  OpenWeatherMapTests
//
//  Created by Gaetano Cerniglia on 19/06/17.
//  Copyright © 2017 Gaetano Cerniglia. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap

class MainControllerTests: XCTestCase {
    let vc = MainController()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetDays() {
        // TEST: MainController.setDays
        // Accepts an Int value (the index) and a Date value
        // Returns: two date format of the string
        // "Today, d MMM yyyy",  if index is 0
        // "E", if index is != 0
        
        let date1 = NSDate(timeIntervalSince1970: 1497873600.0) //date: 19/06/2017 Monday
        let date2 = NSDate(timeIntervalSince1970: 1497960000.0) //date: 20/06/2017 Tuesday
        
        // for the first element of the array, it should return a complete date
        XCTAssertEqual(vc.setDays(date: date1 as Date, i: 0), "Today, 19 Jun 2017")
        
        // for any other element of the array, it should return just the day of the week
        XCTAssertEqual(vc.setDays(date: date2 as Date, i: 1), "Tue")
        
    }
    
    func testSetTemps(){
        // TEST: MainController.tempMin
        // Accepts two double values which are minimum and maximum temperatures
        // Returns: the two values formatted as nn° - nn°
        XCTAssertEqual( vc.setTemps(tempMin: 19.190000000000001, tempMax: 26.539999999999999), "19° - 27°")
    }
    
}
