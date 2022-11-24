//
//  UserListTests.swift
//  UserListTests
//
//  Created by Yanqi Zhao on 24/11/22.
//

import XCTest
@testable import UserList
import UIKit
import CoreData

final class UserListTests: XCTestCase {

    var appDelegate: UserList.AppDelegate!
    let viewModel = ULViewModel()
    
    override func setUpWithError() throws {
        appDelegate = (UIApplication.shared.delegate as! UserList.AppDelegate)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testConfigureData() throws {
        viewModel.configureData {
            print("configureData")
        }
    }
    
    func testLoadMoreData() throws {
        viewModel.loadMoreData {
            print("loadMoreData")
        }
    }
    
    func testSearchData() throws {
        viewModel.searchData(searchText: "Mr Lilian Petit") {
            print("searchData")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
