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
# Microsoft Graph iOS Swift 代码段示例

## 目录

- [简介](#introduction)
- [先决条件](#prerequisites)
- [注册和配置应用](#register-and-configure-the-app)
- [构建和调试](#build-and-debug)
- [运行示例](#running-the-sample)

## 简介

本示例包含介绍如何使用 Microsoft Graph SDK 以发送电子邮件、管理组和使用 Office 365 数据执行其他活动的代码段存储库。它使用[适用于 iOS 的 Microsoft Graph SDK](https://github.com/microsoftgraph/msgraph-sdk-ios) 以结合使用由 Microsoft Graph 返回的数据。

此存储库介绍如何通过在 iOS 应用中向 Microsoft Graph API 生成 HTTP 请求来访问多个资源，包括 Microsoft Azure Active Directory (AD) 和 Office 365 API。

这些代码段简单且是自包含的，你可以在任何合适的时间将其复制并粘贴到你自己的代码中，或将其作为学习如何使用适用于 iOS 的 Microsoft Graph SDK 的资源。

**注意：** 如果可能，请通过“非工作”或测试帐户使用该示例。该示例并非总能清理邮箱和日历中创建的对象。此时，需要手动删除示例邮件和日历事件。此外，请注意获取和发送邮件的代码段和其中的获取、创建、更新和删除事件在所有个人帐户中不可用。只有在这些帐户更新至使用 v2 身份验证终结点时，这些操作才可用。

## 先决条件

此示例要求如下：

- [Xcode](https://developer.apple.com/xcode/downloads/) 版本 10.2.1
- 安装 [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) 成为依存关系管理器。
- Microsoft 工作或个人电子邮件帐户，例如 Office 365 或 outlook.com、hotmail.com 等。你可以注册 [Office 365 开发人员订阅](https://aka.ms/devprogramsignup)，其中包含你开始构建 Office 365 应用所需的资源。

## 注册和配置应用

1. 打开浏览器，并导航到 [Azure Active Directory 管理中心](https://aad.portal.azure.com)，然后使用**个人帐户**（亦称为“Microsoft 帐户”）或**工作/学校帐户**登录。

1. 选择左侧导航栏中的“Azure Active Directory”，再选择“管理”下的“应用注册”。

1. 选择“新注册”。在“注册应用”页上，按如下方式设置值。

    - 将“名称”设置为 `Swift 代码段示例`。
    - 将“受支持的帐户类型”设置为“任何组织目录中的帐户和个人 Microsoft 帐户”。
    - 在“重定向 URI”中，将下拉列表更改为“公共客户端(移动和桌面)”，然后将值设为 `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth`.

1. 选择“注册”。在“Swift 代码段示例”页上，复制并保存“应用程序(客户端) ID”的值，将在下一步中用到它。

## 构建和调试

1. 克隆该存储库

1. 打开**终端**，然后导航到该项目的根。输入下面的命令来安装依赖项。

    ```Shell
    pod install
    ```

1. 打开 Xcode 中的 **Graph-iOS-Swift-Snippets.xcworkspace**。

1. 打开 **ApplicationConstants.swift**。将 `ENTER_CLIENT_ID` 替换为你从注册应用中获得的应用程序 ID。

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. 运行示例。

## 运行示例

启动时，应用将显示常见用户任务列表。这些任务可以基于帐户类型和权限级别运行，并在注释中进行了说明：

- 适用于工作或学校以及个人帐户的任务，如接收和发送电子邮件、创建文件等。
- 仅适用于工作或学校帐户的任务，如获取用户的管理器或帐户照片。
- 仅适用于具有管理权限的工作或学校帐户的任务，如获取组成员或新建用户帐户。

选择想要执行的任务并对其单击以运行。请注意，如果未使用对所选任务适用的权限的帐户进行登录，则会失败。例如，如果在组织中没有管理员特权的帐户中运行某个特定的代码段（如获取所有租户组），则该操作会失败。或者，如果使用个人帐户进行登录并尝试获取登录用户的管理器，则该操作会失败。

## 参与

如果想要参与本示例，请参阅 [CONTRIBUTING.MD](/CONTRIBUTING.md)。

此项目已采用 [Microsoft 开放源代码行为准则](https://opensource.microsoft.com/codeofconduct/)。有关详细信息，请参阅[行为准则常见问题解答](https://opensource.microsoft.com/codeofconduct/faq/)。如有其他任何问题或意见，也可联系 [opencode@microsoft.com](mailto:opencode@microsoft.com)。

## 版权信息

版权所有 (c) 2016 Microsoft。保留所有权利。
