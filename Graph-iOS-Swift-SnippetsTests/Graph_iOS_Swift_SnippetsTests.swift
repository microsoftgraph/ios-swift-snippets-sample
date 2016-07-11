//
//  Graph_iOS_Swift_SnippetsTests.swift
//  Graph-iOS-Swift-SnippetsTests
//
//  Created by Jason Kim on 7/8/16.
//  Copyright © 2016 Jason Kim. All rights reserved.
//

import XCTest

@testable import Graph_iOS_Swift_Snippets

class Graph_iOS_Swift_SnippetsTests: XCTestCase {
    
    var graphClient: MSGraphClient!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        MSGraphClient.setAuthenticationProvider(testAuthProvider())
        graphClient = MSGraphClient.defaultClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // check for getting user information: GET ME
    func testGetUserInformation() {
        let readyExpectation = expectationWithDescription("ready")
        graphClient.me().request().getWithCompletion({ (user: MSGraphUser?, error: NSError?) in
            XCTAssertNotNil(user, "User data should not be nil")
            XCTAssertNil(error, "Error should be nil")
            
            readyExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
}
