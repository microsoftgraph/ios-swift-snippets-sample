---
page_type: sample
products:
- office-365
- office-outlook
- ms-graph
languages:
- swift
extensions:
  contentType: samples
  technologies:
  - Microsoft Graph
  services:
  - Office 365
  - Outlook
  - Groups
  platforms:
  - iOS
  createdDate: 5/26/2016 8:08:35 AM
---
# Microsoft Graph iOS Swift Snippets Sample

## Table of contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Register and configure the app](#register-and-configure-the-app)
- [Build and debug](#build-and-debug)
- [Running the sample](#running-the-sample)

## Introduction

This sample contains a repository of code snippets that show how to use the Microsoft Graph SDK to send email, manage groups, and perform other activities with Office 365 data. It uses the [Microsoft Graph SDK for iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) to work with data returned by Microsoft Graph.

This repository shows you how to access multiple resources, including Microsoft Azure Active Directory (AD) and the Office 365 APIs, by making HTTP requests to the Microsoft Graph API in an iOS app.

These snippets are simple and self-contained, and you can copy and paste them into your own code, whenever appropriate, or use them as a resource for learning how to use the Microsoft Graph SDK for iOS.

**Note:** If possible, please use this sample with a "non-work" or test account. The sample does not always clean up the created objects in your mailbox and calendar. At this time you'll have to manually remove sample mails and calendar events. Also note that the snippets that get and send messages and that get, create, update, and delete events won't work with all personal accounts. These operations will eventually work when those accounts are updated to work with the v2 authentication endpoint.

## Prerequisites

This sample requires the following:

- [Xcode](https://developer.apple.com/xcode/downloads/) version 10.2.1
- Installation of [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)  as a dependency manager.
- A Microsoft work or personal email account such as Office 365, or outlook.com, hotmail.com, etc. You can sign up for [an Office 365 Developer subscription](https://aka.ms/devprogramsignup) that includes the resources that you need to start building Office 365 apps.

## Register and configure the app

1. Open a browser and navigate to the [Azure Active Directory admin center](https://aad.portal.azure.com) and login using a **personal account** (aka: Microsoft Account) or **Work or School Account**.

1. Select **Azure Active Directory** in the left-hand navigation, then select **App registrations** under **Manage**.

1. Select **New registration**. On the **Register an application** page, set the values as follows.

    - Set **Name** to `Swift Snippets Sample`.
    - Set **Supported account types** to **Accounts in any organizational directory and personal Microsoft accounts**.
    - Under **Redirect URI**, change the drop down to **Public client (mobile & desktop)**, and set the value to `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth`.

1. Choose **Register**. On the **Swift Snippets Sample** page, copy the value of the **Application (client) ID** and save it, you will need it in the next step.

## Build and debug

1. Clone this repository

1. Open **Terminal** and navigate to the root of the project. Run the following command to install dependencies.

    ```Shell
    pod install
    ```

1. Open **Graph-iOS-Swift-Snippets.xcworkspace** in Xcode.

1. Open **ApplicationConstants.swift**. Replace `ENTER_CLIENT_ID` with the application ID you got from registering your app.

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. Run the sample.

## Running the sample

When launched, the app displays a list of common user tasks. These tasks can be run based on account type and permission level, and are noted in comments:

- Tasks that are applicable to both work or school and personal accounts, such as getting and sending email, creating files, etc.
- Tasks that are only applicable to work or school accounts, such as getting a user's manager or account photo.
- Tasks that are only applicable to a work or school account with administrative permissions, such as getting group members or creating new user accounts.

Select the task that you want to perform and click on it to run. Be aware that if you log in with an account that doesn't have applicable permissions for the tasks you've selected they'll fail. For example if try to run a particular snippet, like get all tenant groups, from an account that doesn't not have admin privileges in the org the operation will fail. Or, if you log in with a personal account and attempt to get the manager of the signed in user, it will fail.

## Contributing

If you'd like to contribute to this sample, see [CONTRIBUTING.MD](/CONTRIBUTING.md).

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Copyright

Copyright (c) 2016 Microsoft. All rights reserved.
