# Microsoft Graph iOS Swift Snippets Sample

**Table of contents**

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Register and configure the app](#register)
* [Build and debug](#build)
* [Code of interest](#code-of-interest)
* [Running the sample](#running-the-sample)
* [Questions and comments](#questions)
* [Additional resources](#additional-resources)

<a name="introduction"></a>
## Introduction

This sample contains a repository of code snippets that show how to use the Microsoft Graph SDK to send email, manage groups, and perform other activities with Office 365 data. It uses the [Microsoft Graph SDK for iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) to work with data returned by Microsoft Graph.

This repository shows you how to access multiple resources, including Microsoft Azure Active Directory (AD) and the Office 365 APIs, by making HTTP requests to the Microsoft Graph API in an iOS app. 

In addition, the sample uses [msgraph-sdk-ios-nxoauth2-adapter](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter) for authentication. To make requests, an **MSAuthenticationProvider** must be provided which is capable of authenticating HTTPS requests with an appropriate OAuth 2.0 bearer token. We will be using this framework for a sample implementation of MSAuthenticationProvider that can be used to jump-start your project.

 > **Note** The **msgraph-sdk-ios-nxoauth2-adapter** is a sample OAuth implementation for authentication in this app and meant for demonstration purposes.

These snippets are simple and self-contained, and you can copy and paste them into your own code, whenever appropriate, or use them as a resource for learning how to use the Microsoft Graph SDK for iOS.

**Note:** If possible, please use this sample with a "non-work" or test account. The sample does not always clean up the created objects in your mailbox and calendar. At this time you'll have to manually remove sample mails and calendar events. Also note that the snippets that get and send messages and that get, create, update, and delete events won't work with all personal accounts. These operations will eventually work when those accounts are updated to work with the v2 authentication endpoint.

 

<a name="prerequisites"></a>
## Prerequisites ##

This sample requires the following:  
* [Xcode](https://developer.apple.com/xcode/downloads/) version 7.3.1 from Apple 
* Installation of [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)  as a dependency manager.
* A Microsoft work or personal email account such as Office 365, or outlook.com, hotmail.com, etc. You can sign up for [an Office 365 Developer subscription](https://aka.ms/devprogramsignup) that includes the resources that you need to start building Office 365 apps.
* A client id from the registered app at [Microsoft Graph App Registration Portal](https://graph.microsoft.io/en-us/app-registration)
* As stated above, to make authentication requests, an **MSAuthenticationProvider** must be provided which is capable of authenticating HTTPS requests with an appropriate OAuth 2.0 bearer token. 

>**Note:** The sample was tested on Xcode 7.3.1. This sample does not yet support Xcode 8 and iOS10, which uses the Swift 3.0 framework.

<a name="register"></a>
## Register and configure the app

1. Sign into the [App Registration Portal](https://apps.dev.microsoft.com/) using either your personal or work or school account.  
2. Select **Add an app**.  
3. Enter a name for the app, and select **Create application**. The registration page displays, listing the properties of your app.  
4. Under **Platforms**, select **Add platform**.  
5. Select **Mobile application**.  
6. Copy the Client Id (App Id) for later use. You'll need to enter this value into the sample app. The app id is a unique identifier for your app.   
7. Select **Save**.  


<a name="build"></a>
## Build and debug ##

1. Clone this repository
2. Use CocoaPods to import the Microsoft Graph SDK and authentication dependencies:

		pod 'MSGraphSDK'
		pod 'MSGraphSDK-NXOAuth2Adapter'


 This sample app already contains a podfile that will get the pods into  the project. Simply navigate to the project From **Terminal** and run:

        pod install

   For more information, see **Using CocoaPods** in [Additional Resources](#AdditionalResources)

3. Open **Graph-iOS-Swift-Snippets.xcworkspace**
4. Open **ApplicationConstants.swift**. You'll see that the **ClientID** from the registration process can be added to the top of the file.:
   ```swift
   // You will set your application's clientId
   static let clientId = "ENTER_CLIENT_ID"    
   ```
    > Note: For more information on permission scopes required to use this sample, see the below section **Running the sample.**
5. Run the sample.

## Code of interest
All authentication code can be viewed in the **Authentication.swift**. We use a sample implementation of MSAuthenticationProvider extended from NXOAuth2Client to provide login support for registered native apps, automatic refreshing of access tokens, and logout functionality.
The client ID and the scopes used in this sample are defined in **ApplicationConstants.swift**.

All snippets are located under **Graph-iOS-Swift-Snippets/Snippets** inside the project navigator.
- **Snippet.swift** contains protocols, enums, and structs used to construct list of snippets to be used in the app.
- **UserSnippets.swift** contains snippets related to users.
- **GroupsSnippets.swift** contains snippets related to groups.

## Running the sample

When launched, the app displays a list of common user tasks. These tasks can be run based on account type and permission level, and are noted in comments:

- Tasks that are applicable to both work or school and personal accounts, such as getting and sending email, creating files, etc.
- Tasks that are only applicable to work or school accounts, such as getting a user's manager or account photo.
- Tasks that are only applicable to a work or school account with administrative permissions, such as getting group members or creating new user accounts.

Select the task that you want to perform and click on it to run. Be aware that if you log in with an account that doesn't have applicable permissions for the tasks you've selected they'll fail. For example if try to run a particular snippet, like get all tenant groups, from an account that doesn't not have admin privileges in the org the operation will fail. Or, if you log in with a personal account like hotmail.com and attempt to get the manager of the signed in user, it will fail.

Currently this sample app is configured with the following scopes located in ApplicationConstants.swift:

	"https://graph.microsoft.com/User.Read",
    "https://graph.microsoft.com/User.ReadWrite",
    "https://graph.microsoft.com/User.ReadBasic.All",
    "https://graph.microsoft.com/Mail.Send",
    "https://graph.microsoft.com/Calendars.ReadWrite",
    "https://graph.microsoft.com/Mail.ReadWrite",
    "https://graph.microsoft.com/Files.ReadWrite",

You'll be able to perform several operations just using the scopes defined above. However, there are some tasks that require admin privileges to run properly, and the tasks in the UI will be marked as requiring admin access. Administrators may add the following scopes to Authentication.constants.m to run these snippets:

	"https://graph.microsoft.com/Directory.AccessAsUser.All",
	"https://graph.microsoft.com/User.ReadWrite.All"
	"https://graph.microsoft.com/Group.ReadWrite.All"

To see what snippets can be run against an admin, organization, or personal accounts see files UserSnippets.swift and GroupsSnippets.swift under Graph-iOS-Swift-Snippets/Snippets inside project navigator. Each snippet description will detail the level of access.

<a name="contributing"></a>
## Contributing ##

If you'd like to contribute to this sample, see [CONTRIBUTING.MD](/CONTRIBUTING.md).

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

<a name="questions"></a>
## Questions and comments

We'd love to get your feedback about the Microsoft Graph UWP Snippets  Library project. You can send your questions and suggestions to us in the [Issues](https://github.com/microsoftgraph/iOS-objectiveC-snippets-sample/issues) section of this repository.

Your feedback is important to us. Connect with us on [Stack Overflow](http://stackoverflow.com/questions/tagged/office365+or+microsoftgraph). Tag your questions with [MicrosoftGraph].

<a name="additional-resources"></a>
## Additional resources ##

- [Microsoft Graph overview](http://graph.microsoft.io)
- [Office developer code samples](http://dev.office.com/code-samples)
- [Office dev center](http://dev.office.com/)


## Copyright
Copyright (c) 2016 Microsoft. All rights reserved.
