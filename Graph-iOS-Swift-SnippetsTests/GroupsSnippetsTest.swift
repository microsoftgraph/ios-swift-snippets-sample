//
//  GroupsSnippetsTest.swift
//  Graph-iOS-Swift-Snippets
//
//  Created by Jason Kim on 7/18/16.
//  Copyright © 2016 Jason Kim. All rights reserved.
//

import XCTest

@testable import Graph_iOS_Swift_Snippets

class GroupsSnippetsTest: XCTestCase {
    
    var authProvider: testAuthProvider!
    var graphClient: MSGraphClient!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        authProvider = testAuthProvider()
        
        MSGraphClient.setAuthenticationProvider(authProvider)
        graphClient = MSGraphClient.defaultClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCreateUser() {

        let userId = NSProcessInfo.processInfo().globallyUniqueString
        let domainName = authProvider.domainName
        let upn = userId + "@" + domainName
        
        let newUser = MSGraphUser()
        let passwordProfile = MSGraphPasswordProfile()
        passwordProfile.password = "!pass!word1"
        
        newUser.accountEnabled = true
        newUser.displayName = userId
        newUser.passwordProfile = passwordProfile
        newUser.mailNickname = userId
        newUser.userPrincipalName = upn
        
        var readyExpectation = expectationWithDescription("ready")
        
        var validCreatedUser: MSGraphUser!
        
        graphClient.users().request().addUser(newUser) { (createdUser: MSGraphUser?, error: NSError?) in

            XCTAssertNotNil(newUser)
            XCTAssertNil(error)
            
            validCreatedUser = createdUser
            
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        readyExpectation = expectationWithDescription("ready")
        
        
        graphClient.users(validCreatedUser.entityId).request().deleteWithCompletion { (error: NSError?) in
            XCTAssertNil(error)
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    
    func testGetUserGroups() {
      
        let readyExpectation = expectationWithDescription("ready")

        graphClient.me().memberOf().request().getWithCompletion { (userGroupCollection: MSCollection?,
            nextRequest: MSGraphUserMemberOfCollectionWithReferencesRequest?,
            error: NSError?) in
            
            XCTAssertNotNil(userGroupCollection)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testGetAllGroups() {
        
        let readyExpectation = expectationWithDescription("ready")

        graphClient.groups().request().getWithCompletion { (allGroupsCollection: MSCollection?, nextRequest: MSGraphGroupsCollectionRequest?, error: NSError?) in
            XCTAssertNotNil(allGroupsCollection)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    func testGetSingleGroup() {
        
        var readyExpectation = expectationWithDescription("ready")
        var validGroupId: String?
        
        // get all groups first
        graphClient.groups().request().getWithCompletion { (allGroupsCollection: MSCollection?, nextRequest: MSGraphGroupsCollectionRequest?, error: NSError?) in
            XCTAssertNotNil(allGroupsCollection)
            XCTAssertNil(error)
            
            if let allGroups = allGroupsCollection {
                print((allGroups.value[0] as! MSGraphDirectoryObject).dictionaryFromItem()["id"])
                
                validGroupId = (allGroups.value[0] as! MSGraphDirectoryObject).dictionaryFromItem()["id"] as? String
            }
            
            readyExpectation.fulfill()
        }

        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        XCTAssertNotNil(validGroupId)

        
        readyExpectation = expectationWithDescription("ready")

        graphClient.groups(validGroupId).request().getWithCompletion { (singleGroup: MSGraphGroup?, error: NSError?) in

            XCTAssertNotNil(singleGroup)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }

    }
    
    func testGetMembers() {
        
        var readyExpectation = expectationWithDescription("ready")
        var validGroupId: String?
        
        // get all groups first
        graphClient.groups().request().getWithCompletion { (allGroupsCollection: MSCollection?, nextRequest: MSGraphGroupsCollectionRequest?, error: NSError?) in
            XCTAssertNotNil(allGroupsCollection)
            XCTAssertNil(error)
            
            if let allGroups = allGroupsCollection {
                print((allGroups.value[0] as! MSGraphDirectoryObject).dictionaryFromItem()["id"])
                
                validGroupId = (allGroups.value[0] as! MSGraphDirectoryObject).dictionaryFromItem()["id"] as? String
            }
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        XCTAssertNotNil(validGroupId)
        
        
        readyExpectation = expectationWithDescription("ready")
        
        graphClient.groups(validGroupId).members().request().getWithCompletion { (memberCollection: MSCollection?, nextRequest: MSGraphGroupMembersCollectionWithReferencesRequest?, error: NSError?) in
            
            XCTAssertNotNil(memberCollection)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        

    }
    
    func testGetOwners() {
        
        var readyExpectation = expectationWithDescription("ready")
        var validGroupId: String?
        
        // get all groups first
        graphClient.groups().request().getWithCompletion { (allGroupsCollection: MSCollection?, nextRequest: MSGraphGroupsCollectionRequest?, error: NSError?) in
            XCTAssertNotNil(allGroupsCollection)
            XCTAssertNil(error)
            
            if let allGroups = allGroupsCollection {
                print((allGroups.value[0] as! MSGraphDirectoryObject).dictionaryFromItem()["id"])
                
                validGroupId = (allGroups.value[0] as! MSGraphDirectoryObject).dictionaryFromItem()["id"] as? String
            }
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        
        XCTAssertNotNil(validGroupId)
        
        
        readyExpectation = expectationWithDescription("ready")
        
        graphClient.groups(validGroupId).owners().request().getWithCompletion { (memberCollection: MSCollection?, nextRequest: MSGraphGroupOwnersCollectionWithReferencesRequest?, error: NSError?) in
            
            XCTAssertNotNil(memberCollection)
            XCTAssertNil(error)
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        

    }
    
    func testGroupOperations() {

        var validGroup: MSGraphGroup?
        var readyExpectation = expectationWithDescription("ready")

        // create group

        let group = Snippets.createGroupObject()
        graphClient.groups().request().addGroup(group) {  (addedGroup: MSGraphGroup?, error: NSError?) in
            
            XCTAssertNotNil(addedGroup)
            XCTAssertNil(error)
            
            validGroup = addedGroup
            
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }

        
        // update group
       
        guard let singleGroup = validGroup else {
            XCTAssertTrue(true)
            return
        }
        
        singleGroup.displayName = "Update name"
        
        
        print("id", singleGroup.entityId)
        print("name", singleGroup.displayName)
        print("singleGroup", singleGroup)
    
        readyExpectation = expectationWithDescription("ready")

        
        graphClient.groups(singleGroup.entityId).request().update(singleGroup) { (updatedGroup: MSGraphGroup?, error: NSError?) in
            print(updatedGroup)
            print(error)
            
            XCTAssertNotNil(updatedGroup)
            XCTAssertNil(error)
            
            XCTAssertEqual(updatedGroup!.displayName, "Update name")
            readyExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
        // delete group
        readyExpectation = expectationWithDescription("ready")
        
        graphClient.groups(validGroup!.entityId).request().deleteWithCompletion { (error: NSError?) in
            XCTAssertNil(error)
            readyExpectation.fulfill()
        }
        
        
        waitForExpectationsWithTimeout(10) { (error: NSError?) in
            XCTAssertNil(error, "Timeout")
            return
        }
    }
    
    
}
