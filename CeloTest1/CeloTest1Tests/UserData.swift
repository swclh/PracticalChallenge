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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Testing if API does return correct Status :- 200
    func testValidApiCallGetsHTTPStatusCode200() throws {
        
      // given our api url
      let urlString =
        "https://randomuser.me/api/?results=100"
      let url = URL(string: urlString)!
      
      let promise = expectation(description: "Status code: 200")

      // when
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            //then
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
    
    func testUrlToImage() throws{
        
        let imgUrl = "https://randomuser.me/api/portraits/men/75.jpg"
        
        
    }
    
    //Testing if Decoder class does decode JSON from Documentation
    func testCanParseJSON() throws {
    
    //JSON from Documentation
      let JSON = """
        {
        "results": [
          {
            "gender": "male",
            "name": {
              "title": "mr",
              "first": "brad",
              "last": "gibson"
            },
            "location": {
              "street": "9278 new road",
              "city": "kilcoole",
              "state": "waterford",
              "postcode": "93027",
              "coordinates": {
                "latitude": "20.9267",
                "longitude": "-7.9310"
              },
              "timezone": {
                "offset": "-3:30",
                "description": "Newfoundland"
              }
            },
            "email": "brad.gibson@example.com",
            "login": {
              "uuid": "155e77ee-ba6d-486f-95ce-0e0c0fb4b919",
              "username": "silverswan131",
              "password": "firewall",
              "salt": "TQA1Gz7x",
              "md5": "dc523cb313b63dfe5be2140b0c05b3bc",
              "sha1": "7a4aa07d1bedcc6bcf4b7f8856643492c191540d",
              "sha256": "74364e96174afa7d17ee52dd2c9c7a4651fe1254f471a78bda0190135dcd3480"
            },
            "dob": {
              "date": "1993-07-20T09:44:18.674Z",
              "age": 26
            },
            "registered": {
              "date": "2002-05-21T10:59:49.966Z",
              "age": 17
            },
            "phone": "011-962-7516",
            "cell": "081-454-0666",
            "id": {
              "name": "PPS",
              "value": "0390511T"
            },
            "picture": {
              "large": "https://randomuser.me/api/portraits/men/75.jpg",
              "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
              "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
            },
            "nat": "IE"
          }
        ],
        "info": {
          "seed": "fea8be3e64777240",
          "results": 1,
          "page": 1,
          "version": "1.3"
        }
      }
"""
        let jsonData = JSON.data(using: .utf8)!
        
        //here we pass our decoder class
        let decodedData = try JSONDecoder().decode(userDataDecoderClass.self, from: jsonData)
        
        XCTAssertEqual("male", decodedData.results[0].gender)
        XCTAssertEqual("brad", decodedData.results[0].name?.first)
        XCTAssertEqual("gibson", decodedData.results[0].name?.last)
        XCTAssertEqual("kilcoole", decodedData.results[0].location?.city)
        XCTAssertEqual("brad.gibson@example.com", decodedData.results[0].email)
        XCTAssertEqual("mr", decodedData.results[0].name?.title)
        XCTAssertEqual("https://randomuser.me/api/portraits/thumb/men/75.jpg", decodedData.results[0].picture?.thumbnail)
        XCTAssertEqual("https://randomuser.me/api/portraits/men/75.jpg", decodedData.results[0].picture?.large)
        XCTAssertEqual("1993-07-20T09:44:18.674Z", decodedData.results[0].dob?.date)
        
    }

}
