//
//  UserListUITests.swift
//  UserListUITests
//
//  Created by Yanqi Zhao on 24/11/22.
//

import XCTest

final class UserListUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDetail() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Miss Christiane Hobberstad").element.tap()/*[[".cells.containing(.staticText, identifier:\"1945-08-10T09:47:23.888Z\").element",".tap()",".press(forDuration: 1.7);",".cells.containing(.staticText, identifier:\"Miss Christiane Hobberstad\").element"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        app.navigationBars["Detail"].buttons["User List"].tap()
    }
    
    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        tablesQuery.searchFields["Search"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mr Austin Gonzales").element/*[[".cells.containing(.staticText, identifier:\"1958-09-16T08:48:06.641Z\").element",".cells.containing(.staticText, identifier:\"male\").element",".cells.containing(.staticText, identifier:\"Mr Austin Gonzales\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Detail"].buttons["User List"].tap()
    }

    func testScroll() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Mr Lilian Petit").element.swipeUp(velocity: XCUIGestureVelocity(2000))
    }
}
