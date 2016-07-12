//
//  UserSnippetsTest.swift
//  Graph-iOS-Swift-Snippets
//
//  Created by Jason Kim on 7/11/16.
//  Copyright © 2016 Jason Kim. All rights reserved.
//

import XCTest

@testable import Graph_iOS_Swift_Snippets

class UserSnippetsTest: XCTestCase {
    
    var authProvider: testAuthProvider!
    var graphClient: MSGraphClient!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        authProvider = testAuthProvider()
        
        MSGraphClient.setAuthenticationProvider(authProvider)
        graphClient = MSGraphClient.defaultClient()
    }

    // check for getting user information: GET ME
    func testGetMe() {
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

    
    func testUsers() {
        let readyExpectation = expectationWithDescription("ready")
        graphClient.users().request().getWithCompletion {
            (userCollection: MSCollection?, nextRequest: MSGraphUsersCollectionRequest?, error: NSError?) in
            XCTAssertNotNil(userCollection, "Users data should not be nil")
            XCTAssertNil(error, "Error should be nil")
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testDrive() {
        let readyExpectation = expectationWithDescription("ready")
        graphClient.me().drive().request().getWithCompletion {
            (drive: MSGraphDrive?, error: NSError?) in
            XCTAssertNil(error, "Error should be nil")
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    
    
    func testEvent() {
      
        var readyExpectation = expectationWithDescription("ready")
        
        // Create event
        var event = Snippets.createEventObject(isSeries: false)
        
        graphClient.me().calendar().events().request().addEvent(event) { (newEvent: MSGraphEvent?, error: NSError?) in
            XCTAssertNotNil(newEvent)
            XCTAssertNil(error)
            
            event = newEvent!
            readyExpectation.fulfill()
        }

        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        XCTAssertNotNil(event)

        // Update event
        readyExpectation = expectationWithDescription("ready")
        event.subject = "NEW NAME"
        graphClient.me().events(event.entityId).request().update(event) { (newEvent: MSGraphEvent?, error: NSError?) in
            XCTAssertNotNil(newEvent)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        XCTAssertNotNil(event)
    
        // Delete event
        readyExpectation = expectationWithDescription("ready")
        event.subject = "NEW NAME"
        graphClient.me().events(event.entityId).request().deleteWithCompletion({ (error: NSError?) in
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        })
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }

    }
    
    
}
