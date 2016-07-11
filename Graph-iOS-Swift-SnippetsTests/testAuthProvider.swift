//
//  testAuthProvider.swift
//  Graph-iOS-Swift-Connect
//
//  Created by Jason Kim on 6/23/16.
//  Copyright © 2016 Jason Kim. All rights reserved.
//

import UIKit

@testable import Graph_iOS_Swift_Snippets

class testAuthProvider: NSObject, MSAuthenticationProvider {
    
    var accessToken: String = ""
    
    let contentType   = "application/x-www-form-urlencoded"
    let grantType     = "password"
    let tokenEndPoint = "https://login.microsoftonline.com/common/oauth2/token"
    let requestType   = "POST"
    let subjet        = "Email send from test in iOS connect sample"
    let body          = "<html><body>The body of the test email</body></html>"
    let resourceId    = "https://graph.microsoft.com"

    @objc func appendAuthenticationHeaders(request: NSMutableURLRequest!, completion completionHandler: MSAuthenticationCompletion!) {
        
        if accessToken != "" {
            let oauthAuthorizationHeader = String(format: "%@ %@", MS_AADV2_TOKEN_TYPE, accessToken)
            request.setValue(MS_API_HEADER_AUTHORIZATION, forHTTPHeaderField: oauthAuthorizationHeader)
            completionHandler(request, nil)
        }
        else {
            let path = NSBundle(forClass: self.dynamicType).pathForResource("testUserArgs", ofType: "json")
            
            let jsonData = try! NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe)
            let jsonResult = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! NSDictionary
            
            let username = jsonResult["test.username"] as! String
            let password = jsonResult["test.password"] as! String
            let clientId = jsonResult["test.clientId"] as! String
            
            let authRequest = NSMutableURLRequest()
            let bodyString = "grant_type=\(grantType)&resource=\(resourceId)&client_id=\(clientId)&username=\(username)&password=\(password)"
            
            authRequest.URL = NSURL(string: tokenEndPoint)
            authRequest.HTTPMethod = requestType
            authRequest.setValue(contentType, forHTTPHeaderField: "Content_Type")
            authRequest.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(authRequest, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if let validData = data {
                    let jsonDictionary = try! NSJSONSerialization.JSONObjectWithData(validData, options: .AllowFragments) as! NSDictionary
                    if let accessTokenReturned = jsonDictionary["access_token"] {
                        self.accessToken = accessTokenReturned as! String
                    }
                    else {
                        self.accessToken = "WRONG_TOKEN"
                    }
                }
                
                let oauthAuthorizationHeader = String(format: "%@ %@", MS_AADV2_TOKEN_TYPE, self.accessToken)
                request.setValue(oauthAuthorizationHeader, forHTTPHeaderField: MS_API_HEADER_AUTHORIZATION)

                completionHandler(request, error)
            })
            task.resume()
        }
    }
}
