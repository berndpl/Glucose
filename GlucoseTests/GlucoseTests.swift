//
//  SnackedTests.swift
//  SnackedTests
//
//  Created by Bernd on 25.11.21.
//

import XCTest

class GlucoseTests: XCTestCase {
    
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
    
    func testInitialModel() throws {
        XCTAssertEqual(model.items.count, 0)
    }
    
    func testInsertModel() throws {
        let newItem = Item(glucose: 230.0, createDate: Date())
        model.items.append(newItem)
        XCTAssertEqual(model.items.count, 1)
        model.items.append(newItem)
        XCTAssertEqual(model.items.count, 2)
    }
    
    func testHeaders() throws {
        model.items.append(contentsOf:[
            Item(glucose: 230.0, createDate: dateWeekAgo),
            Item(glucose: 230.0, createDate: dateYesterday),
            Item(glucose: 230.0, createDate: dateToday)
            ])
        
        XCTAssertEqual(model.headers[0], Calendar.current.startOfDay(for: dateWeekAgo))
        XCTAssertEqual(model.headers[1], Calendar.current.startOfDay(for: dateYesterday))
        XCTAssertEqual(model.headers[2], Calendar.current.startOfDay(for: dateToday))
        XCTAssertEqual(model.headers.count, 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
