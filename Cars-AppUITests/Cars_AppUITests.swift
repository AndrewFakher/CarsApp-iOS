//
//  Cars_AppUITests.swift
//  Cars-AppUITests
//
//  Created by Andrew on 2/20/22.
//

import XCTest
@testable import Cars_App

class Cars_AppUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testCarListLoaded(){
        app.launch()
        let tableView = app.tables["CarsListCellIdentifier"]
        XCTAssert(tableView.exists)
        
        let secondCell = tableView.cells.element(boundBy: 1)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: secondCell) { () -> Bool in
            XCTAssert(secondCell.exists)
            secondCell.tap()
            return true
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
