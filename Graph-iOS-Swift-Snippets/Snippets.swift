/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import Foundation
import MSGraphSDK

// MARK: - Enum Result
enum Result
{
    case Success(displayText: String?)
    case SuccessDownloadImage(displayImage: UIImage?)
    case Failure(error: MSGraphError)
}

// MARK: - Protocol Snippet
protocol Snippet
{
    func execute(with completion: @escaping (_ result: Result) -> Void)
    
    var needAdminAccess: Bool { get }
    var name: String { get }
}

// MARK: - Snippet group
struct SnippetSection
{
    let name: String
    let snippets: [Snippet]
    
    var count: Int
    {
        get { return snippets.count }
    }
    
    subscript(index: Int) -> Snippet
    {
        get { return snippets[index] }
    }
}

// MARK: - Snippets
struct Snippets
{
    static var graphClient: MSGraphClient = {
        return MSGraphClient.defaultClient()
    }()

    let snippetSections: [SnippetSection]

    init(authenticationProvider: MSAuthenticationProvider)
    {
        let userArray = SnippetSection(name: "User",
                                     snippets: [
                                        GetMe(),
                                        GetUsers(),
                                        GetDrive(),
                                        GetEvents(),
//                                        CreateEvent(),
                                        UpdateEvent(),
                                        DeleteEevnt(),
                                        GetMessages(),
                                        SendMessage(),
                                        SendMessageHTML(),
//                                        GetUserFiles(),
//                                        CreateTextFile(),
//                                        CreateFolder(),
//                                        UploadFile(),
//                                        DownloadFile(),
//                                        UpdateFile(),
//                                        RenameFile(),
//                                        DeleteFile(),
//                                        GetManager(),
//                                        GetDirects(),
//                                        GetPhoto(),
//                                        GetPhotoValue(),
                                        ])
        
        let groupsArray = SnippetSection(name: "Groups",
                                        snippets: [
//                                            CreateUser(),
//                                            GetUserGroups(),
//                                            GetAllGroups(),
//                                            GetSingleGroup(),
//                                            GetMembers(),
//                                            GetOwners(),
//                                            CreateGroup(),
//                                            UpdateGroup(),
//                                            DeleteGroup()
                                            ])
        
        snippetSections = [userArray, groupsArray]
        MSGraphClient.setAuthenticationProvider(authenticationProvider)
    }
    
    var count: Int
    {
        get { return snippetSections.count }
    }
    
    subscript(index: Int) -> SnippetSection
    {
        get { return snippetSections[index] }
    }
}
