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
# Microsoft Graph iOS Swift 程式碼片段範例

## 目錄

- [簡介](#introduction)
- [必要條件](#prerequisites)
- [註冊和設定應用程式](#register-and-configure-the-app)
- [建置和偵錯](#build-and-debug)
- [執行範例](#running-the-sample)

## 簡介

這個範例包含程式碼片段的儲存機制，顯示如何使用 Microsoft Graph SDK 來傳送電子郵件、管理群組，以及執行其他使用 Office 365 資料的活動。它會使用 [Microsoft Graph SDK for iOS](https://github.com/microsoftgraph/msgraph-sdk-ios)，使用 Microsoft Graph 所傳回的資料。

這個儲存機制會示範如何在 iOS 應用程式中向 Microsoft Graph API 發出 HTTP 要求，以存取多個資源 (包括 Microsoft Azure Active Directory (AD) 和 Office 365 API)。

這些程式碼片段簡單且獨立，您可以適當地複製並貼到自己的程式碼，或使用它們做為資源來學習如何使用 Microsoft Graph SDK for iOS。

**注意事項：** 請盡可能以「非工作」或測試帳戶來使用這個範例。範例不會一律清除您的信箱和行事曆中建立的物件。目前，您必須手動移除範例郵件及行事曆事件。另請注意取得和傳送訊息的程式碼片段，以及取得、建立、更新和刪除事件的程式碼片段不適用於所有個人帳戶。當這些帳戶升級為使用 v2 驗證端點時，這些作業最終可以運作。

## 必要條件

此範例需要下列項目：

- [Xcode](https://developer.apple.com/xcode/downloads/)版本 10.2.1
- 安裝 [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) 做為相依性管理員。
- Microsoft 工作或個人電子郵件帳戶，例如 Office 365，或 outlook.com、hotmail.com 等等。您可以註冊 [Office 365 開發人員訂用帳戶](https://aka.ms/devprogramsignup)，其中包含開始建置 Office 365 應用程式所需的資源。

## 註冊和設定應用程式

1. 開啟瀏覽器並瀏覽至[Azure Active Directory 管理中心](https://aad.portal.azure.com)並登入使用**個人帳戶**(也稱為：Microsoft 帳戶）或**公司或學校帳戶**。

1. 在左側導覽中選取 **Azure Active Directory**，然後在**管理**下選取**應用程式註冊**。

1. 選取 **新增註冊**。在**註冊應用程式**頁面上，如下所示設定數值。

    - 設定**名稱**到`迅速的程式碼片段範例`。
    - 在 **支援的帳戶類型**底下，選取 **任何組織目錄中的帳戶及個人的 Microsoft 帳戶**。
    - 在**重新導向 URI**，變更下拉式清單至**公用用戶端（行動裝置及電腦）**，並將值設定為`msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth`。

1. 選擇**註冊**。在**快速的程式碼片段範例**頁面上，複製**應用程式（用戶端）識別碼**的值，儲存起來，在下一個步驟會需要它。

## 建置和偵錯

1. 複製此儲存機制

1. 開啟**終端機**瀏覽至專案的根目錄。執行下列命令以安裝相依性。

    ```Shell
    pod install
    ```

1. 在 Xcode 中開啟 **Graph-iOS-Swift-Snippets.xcworkspace**。

1. 開啟 **ApplicationConstants.swift**。用`ENTER_CLIENT_ID`取代註冊您的應用程式時所提供的應用程式識別碼。

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. 執行範例。

## 執行範例

啟動時，應用程式會顯示一般使用者工作的清單。這些工作可以根據帳戶類型和權限層級執行，並且在註解中附註︰

- 適用於工作或學校和個人帳戶的工作，例如取得和傳送電子郵件、建立檔案等等。
- 只適用於工作或學校帳戶的工作，例如取得使用者的經理或帳戶相片。
- 只適用於具有管理權限的工作或學校帳戶的工作，例如取得群組成員，或建立新的使用者帳戶。

選取您想要執行的工作，並且按一下它以執行。請注意，如果您登入沒有工作的適用權限的帳戶，您選取的工作就會失敗。例如，如果嘗試從組織中沒有系統管理權限的帳戶，執行特定的程式碼片段 (例如取得所有租用戶群組)，則作業會失敗。或者，如果您登入個人帳戶，並且嘗試取得已登入使用者的主管，也會失敗。

## 參與

如果您想要參與這個範例，請參閱 [CONTRIBUTING.MD](/CONTRIBUTING.md)。

此專案已採用[Microsoft 開放原始碼管理辦法](https://opensource.microsoft.com/codeofconduct/)。如需詳細資訊，請參閱[管理辦法常見問題集](https://opensource.microsoft.com/codeofconduct/faq/)，如果有其他問題或意見，請連絡 [opencode@microsoft.com](mailto:opencode@microsoft.com)。

## 著作權

Copyright (c) 2016 Microsoft.著作權所有，並保留一切權利。
