/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */


import Foundation


struct ApplicationConstants {
    // You will set your application's clientId
    static let clientId = "b3aff520-6f80-4bce-a55f-084375d4f8c4"
    
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
    case nsErrorType(error: NSError)
    case unexpectecError(errorString: String)
}
