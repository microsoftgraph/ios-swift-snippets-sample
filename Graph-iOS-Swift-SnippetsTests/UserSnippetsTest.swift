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
            XCTAssertNotNil(drive)
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
    
    
    func testGetMessage() {
        
        let readyExpectation = expectationWithDescription("ready")
        
        graphClient.me().messages().request().getWithCompletion { (collection: MSCollection?, nextRequest: MSGraphUserMessagesCollectionRequest?, error: NSError?) in
            XCTAssertNil(error)
            XCTAssertNotNil(collection)
            
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    
    func testSendMessage() {
        
        // set message
        let message = MSGraphMessage()

        let toRecipient = MSGraphRecipient()
        let msEmailAddress = MSGraphEmailAddress()
        msEmailAddress.address = authProvider.userEmail
        toRecipient.emailAddress = msEmailAddress
        let toRecipientList = [toRecipient]
        message.toRecipients = toRecipientList
        message.subject = "Test mail from unit testing"
        let messageBody = MSGraphItemBody()
        messageBody.contentType = MSGraphBodyType.text()
        messageBody.content = "Mail received from the Office 365 iOS Microsoft Graph Snippets unit testing"
        message.body = messageBody

        // send message
        let readyExpectation = expectationWithDescription("ready")
       
        let mailRequest = graphClient.me().sendMailWithMessage(message, saveToSentItems: true).request()
        mailRequest.executeWithCompletion { (response: [NSObject : AnyObject]?, error: NSError?) in
            print(response?.keys)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            readyExpectation.fulfill()
  
        }
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    
    func testGetUserFiles() {
        let readyExpectation: XCTestExpectation = expectationWithDescription("ready")


        graphClient.me().drive().root().children().request().getWithCompletion { (collection: MSCollection?, next: MSGraphDriveItemChildrenCollectionRequest?, error: NSError?) in
            XCTAssertNotNil(collection)
            XCTAssertNil(error)

            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testFolderOperations() {
        var readyExpectation: XCTestExpectation
        
        // Create folder
        readyExpectation = expectationWithDescription("ready")
        
        // bug on conflictBehavior
        // https://github.com/OneDrive/onedrive-api-docs/issues/391
        var driveItem = MSGraphDriveItem(dictionary: [MSNameConflict.rename().key: MSNameConflict.rename().value])
        driveItem.name = "TestFolder"
        driveItem.folder = MSGraphFolder()
        
        graphClient.me().drive().root().children().request().addDriveItem(driveItem) { (item: MSGraphDriveItem?, error: NSError?) in
            XCTAssertNotNil(item)
            XCTAssertNil(error)
            
            driveItem = item
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        
        // Delete folder
        readyExpectation = expectationWithDescription("ready")
        
        graphClient.me().drive().items(driveItem.entityId).request().deleteWithCompletion { (error :NSError?) in
            XCTAssertNil(error)
            readyExpectation.fulfill()

        }
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testFileOperations() {
        var readyExpectation: XCTestExpectation
        var driveItem: MSGraphDriveItem!
        
        // Create file
        readyExpectation = expectationWithDescription("ready")
       
        let uploadData = "Test".dataUsingEncoding(NSUTF8StringEncoding)
        
        graphClient.me().drive().root().itemByPath("/testFile.txt").contentRequest().uploadFromData(uploadData) { (item: MSGraphDriveItem?, error: NSError?) in
            XCTAssertNotNil(item)
            XCTAssertNil(error)
            
            driveItem = item!
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        // rename file
        readyExpectation = expectationWithDescription("ready")
        
        driveItem.name = "testFile2.txt"
        graphClient.me().drive().items(driveItem.entityId).request().update(driveItem) { (item: MSGraphDriveItem?, error: NSError?) in
            XCTAssertNotNil(item)
            XCTAssertNil(error)
            
            XCTAssertTrue(item!.name == "testFile2.txt")
            
            driveItem = item!
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        

        // download file
        readyExpectation = expectationWithDescription("ready")
       
        graphClient.me().drive().items(driveItem.entityId).contentRequest().downloadWithCompletion { (url: NSURL?, response: NSURLResponse?, error: NSError?) in
            XCTAssertNotNil(url)
            XCTAssertNil(error)
            
            do {
                try NSFileManager.defaultManager().removeItemAtURL(url!)
            } catch let error as NSError {
                XCTAssertNil(error, "Timeout")
            }
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        
        // delete file
        readyExpectation = expectationWithDescription("ready")
        
        graphClient.me().drive().items(driveItem.entityId).request().deleteWithCompletion { (error :NSError?) in
            XCTAssertNil(error)
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
    }
   
    func testGetManager() {
        let readyExpectation: XCTestExpectation = expectationWithDescription("ready")
        
        graphClient.me().manager().request().getWithCompletion { (directoryObject: MSGraphDirectoryObject?, error: NSError?) in
            XCTAssertNotNil(directoryObject)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()

        }

        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testGetDirects() {
        let readyExpectation: XCTestExpectation = expectationWithDescription("ready")
        
        
        graphClient.me().directReports().request().getWithCompletion { (directCollection: MSCollection?, nextRequest: MSGraphUserDirectReportsCollectionWithReferencesRequest?, error: NSError?) in
            XCTAssertNotNil(directCollection)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testGetPhoto() {
        let readyExpectation: XCTestExpectation = expectationWithDescription("ready")
        
        
        graphClient.me().photo().request().getWithCompletion { (photo: MSGraphProfilePhoto?, error: NSError?) in
            XCTAssertNotNil(photo)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testGetPhotoValue() {
        let readyExpectation: XCTestExpectation = expectationWithDescription("ready")
        
        
        graphClient.me().photoValue().downloadWithCompletion { (url: NSURL?, response: NSURLResponse?, error: NSError?) in
            XCTAssertNotNil(url)
            XCTAssertNil(error)
            
            do {
                try NSFileManager.defaultManager().removeItemAtURL(url!)
            } catch let error as NSError {
                XCTAssertNil(error, "Timeout")
            }
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }

    }
    
    
    
    
}
