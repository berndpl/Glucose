//
//  CorelationTests.swift
//  GlucoseTests
//
//  Created by Bernd on 28.11.21.
//

import XCTest

class CorelationTests: XCTestCase {
    
    // Day = 86400

    let dateWeekAgo = Date(timeIntervalSince1970: 0)
    let dateYesterday = Date(timeIntervalSince1970: 6 * 60 * 60 * 24)
    let dateToday = Date(timeIntervalSince1970: 7 * 60 * 60 * 24)
    
    var model:Model = Model(items: [])
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testInsertModel() throws {
        let pickedFoodItem = Food(assetID: "1", createDate: dateYesterday)
        model.insertFood(foodItems: [pickedFoodItem])

        let nearest = dateYesterday.addingTimeInterval(10)
        let localMaximum = dateYesterday.addingTimeInterval(20)
        
        model.insertItems(items: [
            Item(glucose: 210.0, createDate: nearest),
            Item(glucose: 240.0, createDate: localMaximum),
            Item(glucose: 130.0, createDate: dateToday)
        ])

        XCTAssertEqual(model.glucoseRating(date: pickedFoodItem.createDate), 240.0)
    }
    

}
