//
//  UserData.swift
//  CeloTest1Tests
//
//  Created by Shafee Rehman on 29/05/22.
//

import XCTest
@testable import CeloTest1

class UserData: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
    
    }

    //Testing if API URL does return correct Status :- 200
    func testValidApiCallGetsHTTPStatusCode200() throws {
        
      // given our api url
      let urlString =
        "https://randomuser.me/api/?results=100"
      let url = URL(string: urlString)!
      
      let promise = expectation(description: "Status code: 200")

        //URL implementation as same in PerformRequest Action
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if(error != nil){
                XCTFail("Error: \(error!.localizedDescription)")
                return
            }
            else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 200{
                    promise.fulfill()
                }
                else{
                    XCTFail("Status code: \(statusCode)")
                }
                
            }
            
        }
        task.resume()
        
        //due to asynchronous method
        wait(for: [promise], timeout: 5)
        
    }
    
    
    //Testing if Decoder class does decode JSON from Documentation
    func testCanParseJsonAndDecodes() throws {
    
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "jsonObjectForTest", ofType: "json") else { fatalError("json not found") }
        
        guard let JSON = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("unable to convert")
        }
     
        let jsonData = JSON.data(using: .utf8)!
        
        //Here we pass our decoder class
        let decodedData = try JSONDecoder().decode(userDataDecoderClass.self, from: jsonData)
        
        //Testing All data that we will work with
        XCTAssertEqual("male", decodedData.results[0].gender)
        XCTAssertEqual("brad", decodedData.results[0].name?.first)
        XCTAssertEqual("gibson", decodedData.results[0].name?.last)
        XCTAssertEqual("kilcoole", decodedData.results[0].location?.city)
        XCTAssertEqual("brad.gibson@example.com", decodedData.results[0].email)
        XCTAssertEqual("mr", decodedData.results[0].name?.title)
        XCTAssertEqual("https://randomuser.me/api/portraits/thumb/men/75.jpg", decodedData.results[0].picture?.thumbnail)
        XCTAssertEqual("https://randomuser.me/api/portraits/men/75.jpg", decodedData.results[0].picture?.large)
        XCTAssertEqual("1993-07-20T09:44:18.674Z", decodedData.results[0].dob?.date)
        XCTAssertEqual(26, decodedData.results[0].dob?.age)
        
    }

}
