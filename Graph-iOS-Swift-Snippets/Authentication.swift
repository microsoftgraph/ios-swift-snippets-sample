/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */

import Foundation

struct Authentication {
    var authenticationProvider: NXOAuth2AuthenticationProvider?
        {
        get {
            return NXOAuth2AuthenticationProvider.sharedAuth()
        }
    }
    
}

extension Authentication {
    func connectToGraph(withClientId clientId: String,
                                     scopes: [String],
                                     completion:@escaping (_ error: MSGraphError?) -> Void) {
        NXOAuth2AuthenticationProvider.setClientId(clientId, scopes: scopes)
        
        if NXOAuth2AuthenticationProvider.sharedAuth().loginSilent() == true {
            completion(nil)
        }
        else {
            NXOAuth2AuthenticationProvider.sharedAuth()
                .login(with: nil) { (error: Error?) in
                    if let nserror = error {
                        completion(MSGraphError.nsErrorType(error: nserror as NSError))
                    }
                    else {
                        completion(nil)
                    }
            }
        }
   
    }
    
    func disconnect() {
        NXOAuth2AuthenticationProvider.sharedAuth().logout()
    }

}
