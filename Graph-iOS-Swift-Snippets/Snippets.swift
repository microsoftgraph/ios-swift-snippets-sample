/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import Foundation

// MARK: - Enum Result
enum Result {
    case Success(displayText: String?)
    case SuccessDownloadImage(displayImage: UIImage?)
    case Failure(error: MSGraphError)
}

// MARK: - Protocol Snippet
protocol Snippet {
    func execute(with completion:(result: Result) -> Void)
    
    var needAdminAccess: Bool { get }
    var name: String { get }
}

extension Snippet {
    func execute(with completion:(result: Result) -> Void) {
        assert(true, "Empty execution body")
    }
}

// MARK: - Snippet group
struct SnippetSection {
    let name: String
    let snippets: [Snippet]
    
    var count: Int {
        get {
            return snippets.count
        }
    }
    
    subscript(index: Int) -> Snippet {
        get {
            return snippets[index]
        }
    }
}


// MARK: - Snippets
struct Snippets {
    
    static var graphClient: MSGraphClient = {
        return MSGraphClient.defaultClient()
    }()

    let snippetSections: [SnippetSection]

    init(with authenticationProvider: NXOAuth2AuthenticationProvider) {

        let userArray = SnippetSection(name: "User",
                                     snippets: [
                                        GetMe(),
                                        GetUsers(),
                                        GetDrive(),
                                        GetEvents(),
                                        CreateEvent(),
                                        UpdateEvent(),
                                        DeleteEevnt(),
                                        GetMessages(),
                                        SendMessage(),
                                        SendMessageHTML(),
                                        GetUserFiles(),
                                        CreateTextFile(),
                                        CreateFolder(),
                                        UploadFile(),
                                        DownloadFile(),
                                        UpdateFile(),
                                        RenameFile(),
                                        DeleteFile(),
                                        GetManager(),
                                        GetDirects(),
                                        GetPhoto(),
                                        GetPhotoValue(),
                                        ])
        
        let groupsArray = SnippetSection(name: "Groups",
                                        snippets: [
                                            CreateUser(),
                                            GetUserGroups(),
                                            GetAllGroups(),
                                            GetSingleGroup(),
                                            GetMembers(),
                                            GetOwners(),
                                            CreateGroup(),
                                            UpdateGroup(),
                                            DeleteGroup()
                                            ])
        
        snippetSections = [userArray, groupsArray]
        MSGraphClient.setAuthenticationProvider(authenticationProvider)
    }
    
    var count: Int {
        get {
            return snippetSections.count
        }
    }
    
    subscript(index: Int) -> SnippetSection {
        get {
            return snippetSections[index]
        }
    }
}



// MARK: - Helper methods

//
//extension Snippets {
//// Retrieve logged in user's display name and email address
//    static func getUserInfo(with completion:(user: MSGraphUser?, error: NSError?) -> Void) {
//        Snippets.graphClient.me().request().getWithCompletion { (user: MSGraphUser?, error: NSError?) in
//            if let _ = error {
//                completion(user: nil, error: error)
//            }
//            else {
//                completion(user: user, error: nil)
//            }
//        }
//    }
//
//    
//    static func createEvent(with completion:(event: MSGraphEvent?, error: NSError?) -> Void) {
//        let event = Snippets.createEventObject(isSeries: false)
//        
//        Snippets.graphClient.me().calendar().events().request().addEvent(event) { (graphEvent: MSGraphEvent?, error: NSError?) in
//            completion(event: graphEvent, error: error)
//        }
//    }
//    
//    static func createFile(with completion:(file: MSGraphDriveItem?, error: NSError?) -> Void) {
//        let uploadData = "Test".dataUsingEncoding(NSUTF8StringEncoding)
//        
//        Snippets.graphClient.me().drive().root().itemByPath("testSingleFile.text").contentRequest().uploadFromData(uploadData) { (item: MSGraphDriveItem?, error: NSError?) in
//            completion(file: item, error: error)
//          
//        }
//    }
//    
//    static func createGroup(with completion:(group: MSGraphGroup?, error: NSError?) -> Void) {
//        let group = Snippets.createGroupObject()
//        Snippets.graphClient.groups().request().addGroup(group) {
//            (addedGroup: MSGraphGroup?, error: NSError?) in
//            completion(group: addedGroup, error: error)
//        }
//    }
//}
