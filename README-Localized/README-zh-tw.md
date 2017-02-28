# <a name="microsoft-graph-ios-swift-snippets-sample"></a>Microsoft Graph iOS Swift 程式碼片段範例

**目錄**

* [簡介](#introduction)
* [必要條件](#prerequisites)
* [註冊和設定應用程式](#register)
* [建置及偵錯](#build)
* [感興趣的程式碼](#code-of-interest)
* [執行範例](#running-the-sample)
* [問題和建議](#questions)
* [其他資源](#additional-resources)

<a name="introduction"></a>
##<a name="introduction"></a>簡介

這個範例包含程式碼片段的儲存機制，顯示如何使用 Microsoft Graph SDK 來傳送電子郵件、管理群組，以及執行其他使用 Office 365 資料的活動。它會使用 [Microsoft Graph SDK for iOS](https://github.com/microsoftgraph/msgraph-sdk-ios)，使用 Microsoft Graph 所傳回的資料。

這個儲存機制會示範如何存取多個資源，包括 Microsoft Azure Active Directory (AD) 和 Office 365 API，方法是在 iOS 應用程式中對 Microsoft Graph API 進行 HTTP 要求。 

此外，範例使用 [msgraph-sdk-ios-nxoauth2-adapter](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter) 進行驗證。若要提出要求，必須提供 **MSAuthenticationProvider**，它能夠以適當的 OAuth 2.0 持有人權杖驗證 HTTPS 要求。我們會針對 MSAuthenticationProvider 的範例實作使用此架構，可以用來幫助您的專案。

 > **附註** **msgraph-sdk-ios-nxoauth2-adapter** 是這個應用程式中進行驗證的範例 OAuth 實作，且作為示範之用。

這些程式碼片段簡單且獨立，而且您可以在適當時，複製並貼到自己的程式碼，或使用它們做為資源來學習如何使用 Microsoft Graph SDK for iOS。

**附註︰**如果可能的話，請以「非工作」或測試帳戶來使用這個範例。範例不會一律清除您的信箱和行事曆中建立的物件。目前，您必須手動移除範例郵件及行事曆事件。另請注意取得和傳送訊息的程式碼片段，以及取得、建立、更新和刪除事件的程式碼片段不適用於所有個人帳戶。當這些帳戶升級為使用 v2 驗證端點時，這些作業最終可以運作。

 

<a name="prerequisites"></a>
## <a name="prerequisites"></a>必要條件 ##

此範例需要下列項目：  
* 來自 Apple 的 [Xcode](https://developer.apple.com/xcode/downloads/) 版本 7.3.1  
* 安裝 [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) 做為相依性管理員。
* Microsoft 工作或個人電子郵件帳戶，例如 Office 365，或 outlook.com、hotmail.com 等等。您可以註冊 [Office 365 開發人員訂用帳戶](https://aka.ms/devprogramsignup)，其中包含開始建置 Office 365 應用程式所需的資源。
* 已註冊應用程式的用戶端識別碼，來自 [Microsoft Graph 應用程式註冊入口網站](https://graph.microsoft.io/en-us/app-registration)
* 如前所述，若要提出驗證要求，必須提供 **MSAuthenticationProvider**，它能夠以適當的 OAuth 2.0 持有人權杖驗證 HTTPS 要求。 

>**附註：**此範例已在 Xcode 7.3.1 上經過測試。此範例尚未支援使用 Swift 3.0 架構的 Xcode 8 和 iOS10。

<a name="register"></a>
##<a name="register-and-configure-the-app"></a>註冊和設定應用程式

1. 使用您的個人或工作或學校帳戶登入[應用程式註冊入口網站](https://apps.dev.microsoft.com/)。  
2. 選取 [新增應用程式]****。  
3. 為應用程式輸入名稱，然後選取 [建立應用程式]****。[註冊] 頁面隨即顯示，列出您的應用程式的屬性。  
4. 在 [平台]**** 底下，選取 [新增平台]****。  
5. 選取 [行動應用程式]****。  
6. 複製用戶端識別碼 (應用程式識別碼)，以供日後使用。您必須將此值輸入範例應用程式中。應用程式識別碼是您的應用程式的唯一識別碼。   
7. 選取 [儲存]****。  


<a name="build"></a>
## <a name="build-and-debug"></a>建置和偵錯 ##

1. 複製此儲存機制
2. 使用 CocoaPods 來匯入 Microsoft Graph SDK 和驗證相依性：

        pod 'MSGraphSDK'
        pod 'MSGraphSDK-NXOAuth2Adapter'


 此範例應用程式已經包含可將 pods 放入專案的 podfile。只需從 **Terminal** 瀏覽至專案並執行：

        pod install

   如需詳細資訊，請參閱[其他資訊](#AdditionalResources)中的**使用 CocoaPods**

3. 開啟 **Graph-iOS-Swift-Snippets.xcworkspace**
4. 開啟 **ApplicationConstants.swift**您會發現註冊程序的 **ClientID** 可以新增至檔案頂端：
   ```swift
   // You will set your application's clientId
   static let clientId = "ENTER_CLIENT_ID"    
   ```
    > 附註：如需使用這個範例所需的權限範圍的詳細資訊，請參閱以下區段：**執行範例**。
5. 執行範例。

## <a name="code-of-interest"></a>感興趣的程式碼
所有的驗證程式碼可以在 **Authentication.swift** 檔案中檢視。我們使用從 NXOAuth2Client 延伸的 MSAuthenticationProvider 的範例實作，以提供已註冊原生應用程式的登入支援、自動重新整理存取權杖，以及登出功能。這個範例中使用的用戶端識別碼和範圍會在 **ApplicationConstants.swift** 中定義。

所有程式碼片段位於專案導覽器內的 **Graph-iOS-Swift-Snippets/Snippets** 底下。
- **Snippet.swift** 包含通訊協定、列舉和結構，用來建構要在應用程式中使用的程式碼片段的清單。
- **UserSnippets.swift** 包含與使用者相關的程式碼片段。
- **GroupsSnippets.swift** 包含與群組相關的程式碼片段。

## <a name="running-the-sample"></a>執行範例

啟動時，應用程式會顯示一般使用者工作的清單。這些工作可以根據帳戶類型和權限層級執行，並且在註解中附註︰

- 適用於工作或學校和個人帳戶的工作，例如取得和傳送電子郵件、建立檔案等等。
- 只適用於工作或學校帳戶的工作，例如取得使用者的經理或帳戶相片。
- 只適用於具有管理權限的工作或學校帳戶的工作，例如取得群組成員，或建立新的使用者帳戶。

選取您想要執行的工作，並且按一下它以執行。請注意，如果您登入沒有工作的適用權限的帳戶，您選取的工作就會失敗。例如，如果嘗試從沒有組織中的系統管理權限的帳戶，執行特定程式碼片段，像是取得所有租用戶群組，則作業將會失敗。或者，如果您登入個人帳戶 (例如 hotmail.com) 並且嘗試取得已登入使用者的經理，則作業會失敗。

目前這個範例應用程式已設定為位於 ApplicationConstants.swift 的下列範圍：

    "https://graph.microsoft.com/User.Read",
    "https://graph.microsoft.com/User.ReadWrite",
    "https://graph.microsoft.com/User.ReadBasic.All",
    "https://graph.microsoft.com/Mail.Send",
    "https://graph.microsoft.com/Calendars.ReadWrite",
    "https://graph.microsoft.com/Mail.ReadWrite",
    "https://graph.microsoft.com/Files.ReadWrite",

您可以只使用以上定義的範圍執行數個作業。不過，有些工作需要系統管理員權限才能正常執行，而且在 UI 中的工作會被標示為需要系統管理存取權。系統管理員可能會將下列範圍新增至 Authentication.constants.m 以執行這些程式碼片段︰

    "https://graph.microsoft.com/Directory.AccessAsUser.All",
    "https://graph.microsoft.com/User.ReadWrite.All"
    "https://graph.microsoft.com/Group.ReadWrite.All"

若要查看可以針對系統管理、組織或個人帳戶執行哪些程式碼片段，請參閱專案導覽器內 Graph-iOS-Swift-Snippets/Snippets 底下的檔案 UserSnippets.swift 和 GroupsSnippets.swift。每個程式碼片段描述中將詳細說明存取的層級。

<a name="contributing"></a>
## <a name="contributing"></a>參與 ##

如果您想要參與這個範例，請參閱 [CONTRIBUTING.MD](/CONTRIBUTING.md)。

此專案已採用 [Microsoft 開放原始碼執行](https://opensource.microsoft.com/codeofconduct/)。如需詳細資訊，請參閱[程式碼執行常見問題集](https://opensource.microsoft.com/codeofconduct/faq/)，如果有其他問題或意見，請連絡 [opencode@microsoft.com](mailto:opencode@microsoft.com)。

<a name="questions"></a>
## <a name="questions-and-comments"></a>問題和建議

我們很樂於收到您對於 Microsoft Graph UWP Snippets Library 專案的意見反應。您可以在此儲存機制的[問題](https://github.com/microsoftgraph/iOS-objectiveC-snippets-sample/issues)區段中，將您的問題及建議傳送給我們。

我們很重視您的意見。請透過 [Stack Overflow](http://stackoverflow.com/questions/tagged/office365+or+microsoftgraph) 與我們連絡。以 [MicrosoftGraph] 標記您的問題。

<a name="additional-resources"></a>
## <a name="additional-resources"></a>其他資源 ##

- [Microsoft Graph 概觀](http://graph.microsoft.io)
- [Office 開發人員程式碼範例](http://dev.office.com/code-samples)
- [Office 開發人員中心](http://dev.office.com/)


## <a name="copyright"></a>著作權
Copyright (c) 2016 Microsoft.著作權所有，並保留一切權利。
