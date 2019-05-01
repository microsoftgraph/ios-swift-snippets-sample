/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See LICENSE in the project root for license information.
 */

import Foundation
import MSAL
import MSGraphSDK

class AuthenticationProvider: NSObject, MSAuthenticationProvider
{
    var accessToken: String?
    var account: MSALAccount?
    var msalClient: MSALPublicClientApplication
    
    init(clientId: String, authority: MSALAuthority) throws
    {
        let config = MSALPublicClientApplicationConfig(clientId: clientId)
        msalClient = try MSALPublicClientApplication(configuration: config)
    }
    
    func acquireAuthToken(scopes: [String], completion:@escaping (_ success:Bool, _ error: NSError?) -> Void)
    {
        var completionBlock: MSALCompletionBlock?
        completionBlock = { (result, error) in
            
            if let error = error as NSError?
            {
                if (error.domain == MSALErrorDomain)
                {
                    let msalError = MSALError(rawValue: error.code)!
                    
                    switch msalError {
                    case MSALError.interactionRequired:
                        let interactiveParameters = MSALInteractiveTokenParameters(scopes: scopes)
                        self.msalClient.acquireToken(with: interactiveParameters, completionBlock: completionBlock!)
                        
                    case MSALError.serverDeclinedScopes:
                        var declinedScopes = [String]()
                        if let ds = error.userInfo[MSALDeclinedScopesKey] as? Array<String> { declinedScopes = ds }
                        print("The following scopes were declined: ", declinedScopes)
                        
                        var grantedScopes = [String]()
                        if let gs = error.userInfo[MSALGrantedScopesKey] as? Array<String> { grantedScopes = gs }
                        print("Trying to acquire a token with granted scopes: ", grantedScopes)
                        
                        var accounts = [MSALAccount]()
                        do {
                            accounts = try self.msalClient.allAccounts()
                        } catch let error as NSError {
                            print("Error: ", error)
                            completion(false, error)
                            return
                        }
                        
                        if let account = accounts.first {
                            let silentParameters = MSALSilentTokenParameters(scopes: grantedScopes, account: account)
                            self.msalClient.acquireTokenSilent(with: silentParameters, completionBlock: completionBlock!)
                        } else {
                            completion(false, nil)
                        }
                        
                    case MSALError.internal:
                        
                        // Log the error, then inspect the MSALInternalErrorCodeKey
                        // in the userInfo dictionary.
                        // More detailed information about the specific error
                        // under MSALInternalErrorCodeKey can be found in MSALInternalError enum.
                        print("Failed with internal MSAL error ", error)
                    default:
                        print("Failed with unknown MSAL error ", error)
                    }
                }
                
                completion(false, error)
                
            } else if let result = result {
                self.accessToken = result.accessToken
                self.account = result.account
                completion(true, nil)
                
                return
            } else {
                assert(false, "result and error should never be nil at the same time.")
            }
        }
        
        var accounts = [MSALAccount]()
        do {
            accounts = try msalClient.allAccounts()
        } catch let error as NSError {
            print("Error: ", error)
        }
        
        if let account = accounts.first {
            let silentParameters = MSALSilentTokenParameters(scopes: scopes, account: account)
            msalClient.acquireTokenSilent(with: silentParameters, completionBlock: completionBlock!)
        } else {
            let interactiveParameters = MSALInteractiveTokenParameters(scopes: scopes)
            msalClient.acquireToken(with: interactiveParameters, completionBlock: completionBlock!)
        }
    }
    
    func disconnect()
    {
        guard let account = self.account else { return }
        
        do {
            try msalClient.remove(account)
        } catch let error as NSError {
            print("Error: ", error)
        }
    }
    
    // MARK: - MSAuthenticationProvider
    
    func appendAuthenticationHeaders(_ request: NSMutableURLRequest!, completion completionHandler: MSAuthenticationCompletion!)
    {
        if let accessToken = self.accessToken {
            let header = "Bearer \(accessToken)"
            request.setValue(header, forHTTPHeaderField:"Authorization")
        }
        
        completionHandler(request, nil);
    }
}
