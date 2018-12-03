/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import Foundation


struct ApplicationConstants {
    // You will set your application's clientId
    static let clientId = "619a3897-5a78-4a84-b5a8-4bcd22100f29"
    
    // Set scopes
    static let scopes   = [ "https://graph.microsoft.com/User.Read",
                            "https://graph.microsoft.com/User.ReadWrite",
                            "https://graph.microsoft.com/User.ReadBasic.All",
                            "https://graph.microsoft.com/Mail.Send",
                            "https://graph.microsoft.com/Calendars.ReadWrite",
                            "https://graph.microsoft.com/Mail.ReadWrite",
                            "https://graph.microsoft.com/Files.ReadWrite"
// Admin-only scopes. Uncomment these if you're running the sample with an admin work account.
// You won't be able to sign in with a non-admin work account if you request these scopes.
                            , "https://graph.microsoft.com/Directory.AccessAsUser.All",
                            "https://graph.microsoft.com/User.ReadWrite.All"
    ]
}


enum MSGraphError: Error {
    case NSErrorType(error: NSError)
    case UnexpectecError(errorString: String)
}
