/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import Foundation

// MARK: - User snippets

// Returns select information about the signed-in user from Azure Active Directory. Applies to personal or work accounts
struct GetMe: Snippet
{
    let name = "Get me"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        Snippets.graphClient.me().request()?.getWithCompletion({ (user, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                let displayName = user?.displayName ?? ""
                let displayString = "Retrieval of user account information succeeded for \(displayName)"
                completion(.Success(displayText: displayString))
            }
        })
        
    }
}

// Returns all of the users in your tenant's directory.
// Applies to personal or work accounts.
// nextRequest is a subsequent request if there are more users to be loaded.
struct GetUsers: Snippet
{
    let name = "Get users"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        Snippets.graphClient.users().request()?.getWithCompletion({ (userCollection, nextRequest, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                var displayString = "List of users:\n"
                if let users = userCollection {
                    
                    for user: MSGraphUser in users.value as! [MSGraphUser] {
                        displayString += user.displayName + "\n"
                    }
                }
                
                if let _ = nextRequest {
                    displayString += "Next request available for more users"
                }
                completion(.Success(displayText: displayString))
            }
        })
    }
}

// Gets the signed-in user's drive from OneDrive.
// Applies to personal or work accounts
struct GetDrive: Snippet
{
    let name = "Get drive"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        Snippets.graphClient.me().drive().request()?.getWithCompletion({ (drive, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                var displayString = "Drive information:\n"
                if let userDrive = drive {
                    displayString += "Drive type is " + userDrive.driveType + "\n"
                    displayString += "Total Quote is " + String(userDrive.quota.total)
                }
                completion(.Success(displayText: displayString))
            }
        })
    }
    
}

// Gets the signed-in user's events.
// Applies to personal or work accounts
struct GetEvents: Snippet
{
    let name = "Get events"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        Snippets.graphClient.me().events().request()?.getWithCompletion({ (eventCollection, nextRequest, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                var displayString = "List of events (subjects):\n"
                if let events = eventCollection {
                    for event: MSGraphEvent in events.value as! [MSGraphEvent] {
                        displayString += event.subject + "\n\n"
                    }
                }
                
                if let _ = nextRequest {
                    displayString += "Next request available for more users"
                }
                
                completion(.Success(displayText: displayString))
            }
        })
    }
}


// Create an event in the signed in user's calendar.
// Applies to personal or work accounts
//struct CreateEvent: Snippet
//{
//    let name = "Create event"
//    let needAdminAccess: Bool = false
//
//    func execute(with completion: @escaping (_ result: Result) -> Void)
//    {
//        let event = Snippets.createEventObject(isSeries: false)
//
//        Snippets.graphClient.me().calendar().events().request().addEvent(event) {
//            (event: MSGraphEvent?, error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                let displayString = "Event created with id \(event!.entityId)"
//                completion(result: .Success(displayText: displayString))
//            }
//        }
//    }
//}
//
//
// Updates an event in the signed in user's calendar.
// Applies to personal or work accounts
struct UpdateEvent: Snippet
{
    let name = "Update event"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        // Enter a valid event id
        let eventId = "ENTER_VALID_EVENT_ID"
        
        // Get an event and then update
        
        Snippets.graphClient.me().events(eventId).request()?.getWithCompletion({ (event, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                guard let validEvent = event else {
                    completion(.Failure(error: MSGraphError.UnexpectecError(errorString: "Event ID not returned")))
                    return
                }
                validEvent.subject = "New Name"
                
                Snippets.graphClient.me().events(validEvent.entityId).request()?.update(validEvent, withCompletion: { (updatedEvent, error) in
                    if let nsError = error {
                        completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
                    }
                    else {
                        let displayString = "Event updated with a new subject"
                        completion(.Success(displayText: displayString))
                    }
                })
            }
        })
    }
}


// Deletes an event in the signed in user's calendar.
// Applies to personal or work accounts
struct DeleteEevnt: Snippet
{
    let name = "Delete event"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        // Enter a valid event id
        let eventId = "ENTER_VALID_EVENT_ID"
        
        Snippets.graphClient.me().events(eventId)?.request()?.delete(completion: { (error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                completion(.Success(displayText: "Deleted calendar event id: \(eventId)"))
            }
        })
    }
}


// Gets the signed-in user's messages.
// Applies to personal or work accounts
struct GetMessages: Snippet
{
    let name = "Get messages"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        Snippets.graphClient.me().messages().request()?.getWithCompletion({ (messageCollection, nextRequest, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                var displayString = "List of messages:\n"
                if let messages = messageCollection {
                    
                    for message: MSGraphMessage in messages.value as! [MSGraphMessage] {
                        displayString += message.subject + "\n\n"
                    }
                }
                
                if let _ = nextRequest {
                    displayString += "Next request available for more messages"
                }
                
                completion(.Success(displayText: displayString))
            }
        })
        
    }
}


// Create and send a message as the signed-in user.
// Applies to personal or work accounts
struct SendMessage: Snippet
{
    let name = "Send mail"
    let needAdminAccess: Bool = false
    
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        // ENTER EMAIL ADDRESS
        let recipientEmailAddress = "ENTER_EMAIL_ADDRESS"
        
        // ===================================================================
        // Set message
        // ===================================================================
        let message = MSGraphMessage()
        
        // Set recipients
        let toRecipient = MSGraphRecipient()
        let msEmailAddress = MSGraphEmailAddress()
        msEmailAddress.address = recipientEmailAddress
        toRecipient.emailAddress = msEmailAddress
        let toRecipientList = [toRecipient]
        message.toRecipients = toRecipientList
        
        // Subject
        message.subject = "Mail received from the Office 365 iOS Microsoft Graph Snippets Sample"
        
        // Body
        let messageBody = MSGraphItemBody()
        messageBody.contentType = MSGraphBodyType.text()
        messageBody.content = "Mail received from the Office 365 iOS Microsoft Graph Snippets Sample"
        
        message.body = messageBody
        
        // ===================================================================
        // Send message
        // ===================================================================
        
        guard let mailRequest = Snippets.graphClient.me()?.sendMail(with: message, saveToSentItems: true)?.request() else { return }
        mailRequest.execute { (response, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                completion(.Success(displayText: "Message sent"))
            }
        }
    }
}


// Create and send a message as the signed-in user.
// This one uses HTML message.
// Applies to personal or work accounts
struct SendMessageHTML: Snippet
{
    let name = "Send HTML mail"
    let needAdminAccess: Bool = false
    func execute(with completion: @escaping (_ result: Result) -> Void)
    {
        // ENTER EMAIL ADDRESS
        let recipientEmailAddress = "ENTER_EMAIL_ADDRESS"
        
        // ===================================================================
        // Set message
        // ===================================================================
        let message = MSGraphMessage()
        
        // Set recipients
        let toRecipient = MSGraphRecipient()
        let msEmailAddress = MSGraphEmailAddress()
        msEmailAddress.address = recipientEmailAddress
        toRecipient.emailAddress = msEmailAddress
        let toRecipientList = [toRecipient]
        message.toRecipients = toRecipientList
        
        // Subject
        message.subject = "Mail received from the Office 365 iOS Microsoft Graph Snippets Sample"
        
        // Body
        let messageBody = MSGraphItemBody()
        messageBody.contentType = MSGraphBodyType.html()
        
        guard let emailBodyFilePath = Bundle.main.path(forResource: "EmailBody", ofType: "html") else {
            completion(.Failure(error: MSGraphError.UnexpectecError(errorString: "EmailBody.html not found in resources")))
            return
        }
        messageBody.content = try! String(contentsOfFile: emailBodyFilePath, encoding: String.Encoding.utf8)
        message.body = messageBody
        
        // ===================================================================
        // Send message
        // ===================================================================
        let mailRequest = Snippets.graphClient.me().sendMail(with: message, saveToSentItems: true).request()
        mailRequest?.execute(completion: { (response, error) in
            if let nsError = error {
                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
            }
            else {
                completion(.Success(displayText: "Message sent"))
            }
        })
    }
}
//
//
//// Returns all of the user's files.
//// Applies to personal or work accounts
//struct GetUserFiles: Snippet {
//    let name = "Get user files"
//    let needAdminAccess: Bool = false
//    
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        Snippets.graphClient.me().drive().root().children().request().getWithCompletion {
//            (fileCollection: MSCollection?, nextRequest: MSGraphDriveItemChildrenCollectionRequest?, error: NSError?) in
//            
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                var displayString = "List of files: \n"
//                if let files = fileCollection {
//                    
//                    for file: MSGraphDriveItem in files.value as! [MSGraphDriveItem] {
//                        displayString += "\(file.name): \(file.size) \n"
//                    }
//                }
//                
//                if let _ = nextRequest {
//                    displayString += "Next request available for more files"
//                }
//                
//                completion(result: .Success(displayText: displayString))
//            }
//        }
//    }
//}
//
//
//// Create a text file in the signed in user's OneDrive account.
//// If a file already exists it will be overwritten.
//// Applies to personal or work accounts
//struct CreateTextFile: Snippet {
//    let name = "Create text file"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        let uploadData = "Test".dataUsingEncoding(NSUTF8StringEncoding)
//        
//        Snippets.graphClient.me().drive().root().itemByPath("Test Folder/testTextfile.text").contentRequest().uploadFromData(uploadData) {
//            (item: MSGraphDriveItem?, error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                completion(result: .Success(displayText: "File created at Test Folder/testTextfile.text"))
//            }
//        }
//    }
//}
//
//
//// Upload an image file in the signed in user's OneDrive account.
//// Applies to personal or work accounts
//struct UploadFile: Snippet {
//    let name = "Upload image file"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        let urlpath = NSBundle.mainBundle().pathForResource("SampleImage", ofType: "png")
//        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
//        
//        Snippets.graphClient.me().drive().root().itemByPath("sampleImage.png").contentRequest().uploadFromFile(url) {
//            (item: MSGraphDriveItem?, error: NSError!) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                completion(result: .Success(displayText: "File uploaded (sampleImage.png)"))
//            }
//        }
//    }
//}
//
//
//// Creates a new folder in the signed in user's OneDrive account.
//// Applies to personal or work accounts
//struct CreateFolder: Snippet {
//    let name = "Create folder"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        
//        let driveItem = MSGraphDriveItem(dictionary: [MSNameConflict.rename().key: MSNameConflict.rename().value])
//        driveItem.name = "TestFolder"
//        driveItem.folder = MSGraphFolder()
//        
//        // Use itemByPath as below to create a subfolder under an existing folder
//        // Snippets.graphClient.me().drive().root().itemByPath("existingFolder").request().getWithCompletion(
//        Snippets.graphClient.me().drive().root().request().getWithCompletion { (item: MSGraphDriveItem?, error: NSError?) in
//            
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            
//            guard let validItem = item else {
//                completion(result: .Failure(error: MSGraphError.UnexpectecError(errorString: "Valid item not returned for a path")))
//                return
//            }
//            
//            Snippets.graphClient.me().drive().items(validItem.entityId).children().request().addDriveItem(driveItem) {
//                (item: MSGraphDriveItem?, error: NSError?) in
//                if let nsError = error {
//                    completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//                }
//                else {
//                    completion(result: .Success(displayText: "Created a folder \(item!.name)"))
//                }
//            }
//        }
//    }
//}
//
//
//// Downloads a file into the signed in user's OneDrive account. 
//// Applies to personal or work accounts
//struct DownloadFile: Snippet {
//    let name = "Download file"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        
//        // Enter a valid event id
//        let fileId = "ENTER_VALID_ID"
//        
//        Snippets.graphClient.me().drive().items(fileId).contentRequest().downloadWithCompletion({
//            (url: NSURL?, response: NSURLResponse?, error: NSError?) in
//            
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                guard let downloadedUrl = url else {
//                    completion(result: .Failure(error: MSGraphError.UnexpectecError(errorString: "Downloaded URL not found")))
//                    return
//                }
//                completion(result: .Success(displayText: "Downloaded file at \(downloadedUrl.absoluteString)"))
//            }
//        })
//    }
//}
//
//
//// Uploads a file in the signed in user's OneDrive account.
//// Applies to personal or work accounts
//struct UpdateFile: Snippet {
//    let name = "Update file"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        
//        // Enter a valid event id
//        let fileId = "ENTER_VALID_ID"
//        
//        let uploadData = "newTextValue".dataUsingEncoding(NSUTF8StringEncoding)
//        Snippets.graphClient.me().drive().items(fileId).contentRequest().uploadFromData(uploadData, completion: {
//            (updatedItem: MSGraphDriveItem?, error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                completion(result: .Success(displayText: "File \(updatedItem!.name) contents updated"))
//            }
//        })
//    }
//}
//
//
//// Renames a file in the signed in user's OneDrive account.
//// Applies to personal or work accounts
//struct RenameFile: Snippet {
//    let name = "Rename file"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        
//        // Enter a valid event id
//        let fileId = "ENTER_VALID_ID"
//      
//        Snippets.graphClient.me().drive().items(fileId).request().getWithCompletion {
//            (file: MSGraphDriveItem?, error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                guard let validFile = file else {
//                    completion(result: .Failure(error: MSGraphError.UnexpectecError(errorString: "Valid file not returned")))
//                    return
//                }
//                
//                validFile.name = "NewTextFileName"
//                Snippets.graphClient.me().drive().items(validFile.entityId).request().update(validFile, withCompletion: {
//                    (updateItem: MSGraphDriveItem?, error: NSError?) in
//                    if let nsError = error {
//                        completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//                    }
//                    else {
//                        completion(result: .Success(displayText: "New name is \(updateItem!.name)"))
//                    }
//                })
//            }
//        }
//    }
//}
//
//
//// Deletes a file in the signed in user's OneDrive account. 
//// Applies to personal or work accounts
//struct DeleteFile: Snippet {
//    let name = "Delete file"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        
//        // Enter a valid event id
//        let fileId = "ENTER_VALID_ID"
//        
//        Snippets.graphClient.me().drive().items(fileId).request().deleteWithCompletion({ (error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                completion(result: .Success(displayText: "File deleted"))
//            }
//        })
//    }
//}
//
//
//// Get user's manager if they have one.
//// Applies to work accounts only
//struct GetManager: Snippet {
//    let name = "Get manager"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        Snippets.graphClient.me().manager().request().getWithCompletion {
//            (directoryObject: MSGraphDirectoryObject?, error: NSError?) in
//            
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                var displayString: String = "Manager information: \n"
//                
//                if let manager = directoryObject {
//                    if let managerName = manager.dictionaryFromItem()["displayName"] {
//                        displayString += "Manager is \(managerName)\n\n"
//                    }
//                    else {
//                        displayString += "No manager"
//                    }
//                    displayString += "Full object is\n\(manager)"
//                }
//                completion(result: .Success(displayText: "\(displayString)"))
//            }
//        }
//    }
//}
//
//
//// Get user's direct reports
//// Applies to work accounts only
//struct GetDirects: Snippet {
//    let name = "Get directs"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        Snippets.graphClient.me().directReports().request().getWithCompletion { (directCollection: MSCollection?, nextRequest: MSGraphUserDirectReportsCollectionWithReferencesRequest?, error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                var displayString = "List of directs: \n"
//                if let directs = directCollection {
//                    
//                    for direct: MSGraphDirectoryObject in directs.value as! [MSGraphDirectoryObject] {
//                        guard let name = direct.dictionaryFromItem()["displayName"] else {
//                            completion(result: .Failure(error: MSGraphError.UnexpectecError(errorString: "Display name not found")))
//                            return
//                        }
//                        displayString += "\(name)\n"
//                    }
//                }
//                
//                if let _ = nextRequest {
//                    displayString += "Next request available for more users"
//                }
//                
//                completion(result: .Success(displayText: "\(displayString)"))
//            }
//        }
//    }
//}
//
//
//
//// Gets the signed-in user's photo data if they have a photo. 
//// This snippet will return metadata for the user photo.
//// Applies to work accounts only
//struct GetPhoto: Snippet {
//    let name = "Get photo"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        Snippets.graphClient.me().photo().request().getWithCompletion {
//            (photo: MSGraphProfilePhoto?, error: NSError?) in
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//            }
//            else {
//                
//                guard let photoMetric = photo else {
//                    completion(result: .Failure(error: MSGraphError.UnexpectecError(errorString: "Photo width and height not found")))
//                    return
//                }
//                let displayString = "Photo size is \(photoMetric.height) x \(photoMetric.width)"
//                completion(result: .Success(displayText: "\(displayString)"))
//            }
//        }
//    }
//}
//
//
//// Creates a new user in the tenant.
//// Applicable to work accounts with admin rights
//struct GetPhotoValue: Snippet {
//    let name = "Get photo value"
//    let needAdminAccess: Bool = false
//    func execute(with completion: @escaping (_ result: Result) -> Void) {
//        
//        Snippets.graphClient.me().photoValue().downloadWithCompletion {
//            (url: NSURL?, response: NSURLResponse?, error: NSError?) in
//            
//            if let nsError = error {
//                completion(.Failure(error: MSGraphError.NSErrorType(error: nsError as NSError)))
//                return
//            }
//            
//            guard let picUrl = url else {
//                completion(result: .Failure(error: MSGraphError.UnexpectecError(errorString: "No downloaded URL")))
//                return
//            }
//            
//            let picData = NSData(contentsOfURL: picUrl)
//            let picImage = UIImage(data: picData!)
//            
//            completion(result: .SuccessDownloadImage(displayImage: picImage))
//        }
//    }
//}
//
//
//// MARK: - Helper methods
//
//extension Snippets {
//    
//// Helper for creating a event object. 
//// Set series to true to create a recurring event.
//    
//    static func createEventObject(isSeries series: Bool) -> MSGraphEvent {
//        
//        let event = MSGraphEvent()
//        event.subject = "Event Subject"
//        event.body = MSGraphItemBody()
//        event.body.contentType = MSGraphBodyType.text()
//        event.body.content = "Sample event body"
//        event.importance = MSGraphImportance.normal()
//        
//        let startDate: NSDate = NSDate(timeInterval: 30 * 60, sinceDate: NSDate())
//        let endDate: NSDate = NSDate(timeInterval: 30 * 60, sinceDate: startDate)
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
//        
//        event.start = MSGraphDateTimeTimeZone()
//        event.start.dateTime = dateFormatter.stringFromDate(startDate)
//        
//        // For more timezone settings, visit this link
//        // http://graph.microsoft.io/en-us/docs/api-reference/v1.0/resources/datetimetimezone
//        event.start.timeZone = "Pacific/Honolulu"
//        
//        event.end = MSGraphDateTimeTimeZone()
//        event.end.dateTime = dateFormatter.stringFromDate(endDate)
//        event.end.timeZone = "Pacific/Honolulu"
//        
//        if !series {
//            event.type = MSGraphEventType.singleInstance()
//        }
//        else {
//            event.type = MSGraphEventType.seriesMaster()
//            
//            event.recurrence = MSGraphPatternedRecurrence()
//            event.recurrence.pattern = MSGraphRecurrencePattern()
//            event.recurrence.pattern.interval = 1
//            event.recurrence.pattern.type = MSGraphRecurrencePatternType.weekly()
//            event.recurrence.pattern.daysOfWeek = [MSGraphDayOfWeek.friday()]
//            event.recurrence.range = MSGraphRecurrenceRange()
//            event.recurrence.range.type = MSGraphRecurrenceRangeType.noEnd()
//            event.recurrence.range.startDate = MSDate(NSDate: startDate)
//        }
//        return event
//    }
//}


