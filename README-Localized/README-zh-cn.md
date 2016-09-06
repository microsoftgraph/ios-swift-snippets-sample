# Microsoft Graph iOS Swift 代码段示例

**目录**

* [简介](#简介)
* [先决条件](#先决条件)
* [注册和配置应用](#注册和配置应用)
* [构建和调试](#构建和调试)
* [相关代码](#相关代码)
* [运行示例](#运行示例)
* [问题和意见](#问题和意见)
* [其他资源](#其他资源)

<a name="introduction"></a>
##简介

该示例包含介绍如何使用 Microsoft Graph SDK 以发送电子邮件、管理组和使用 Office 365 数据执行其他活动的代码段存储库。 它使用 [适用于 iOS 的 Microsoft Graph SDK](https://github.com/microsoftgraph/msgraph-sdk-ios) 以结合使用由 Microsoft Graph 返回的数据。

此存储库介绍如何通过在 iOS 应用中向 Microsoft Graph API 生成 HTTP 请求来访问多个资源，包括 Microsoft Azure Active Directory (AD) 和 Office 365 API。 

此外，该示例使用 [msgraph-sdk-ios-nxoauth2-adapter](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter) 用于身份验证。 若要生成请求，必须提供 **MSAuthenticationProvider**（它能够使用适当的 OAuth 2.0 持有者令牌对 HTTPS 请求进行身份验证）。 我们将对 MSAuthenticationProvider 的示例实现使用此框架，以快速启动你的项目。

 > **注意** **msgraph-sdk-ios-nxoauth2-adapter** 是该应用中进行身份验证的示例 OAuth 实现，用于演示目的。

这些代码段简单且是自包含的，你可以在任何合适的时间将其复制并粘贴到你自己的代码中，或将其作为学习如何使用适用于 iOS 的 Microsoft Graph SDK 的资源。

**注意：**如果可能，请通过“非工作”或测试帐户使用该示例。 该示例并非总能清理邮箱和日历中创建的对象。 此时，需要手动删除示例邮件和日历事件。 此外，请注意获取和发送邮件的代码段和其中的获取、创建、更新和删除事件在所有个人帐户中不可用。 只有在这些帐户更新至使用 v2 身份验证终结点时，这些操作才可用。

 

<a name="prerequisites"></a>
## 先决条件 ##

此示例需要以下各项：  
* Apple 的 [Xcode](https://developer.apple.com/xcode/downloads/)
* 安装 [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) 成为依存关系管理器。
* Microsoft 工作或个人电子邮件帐户，例如 Office 365 或 outlook.com、hotmail.com 等。你可以注册 [Office 365 开发人员订阅](https://aka.ms/devprogramsignup)，其中包含开始构建 Office 365 应用所需的资源。
* [Microsoft Graph 应用注册门户](https://graph.microsoft.io/en-us/app-registration) 中已注册应用的客户端 ID
* 如上所述，若要生成身份验证请求，必须提供 **MSAuthenticationProvider**（它能够使用适当的 OAuth 2.0 持有者令牌对 HTTPS 请求进行身份验证）。 


      
<a name="register"></a>
##注册和配置应用

1. 使用个人或工作或学校帐户登录到 [应用注册门户](https://apps.dev.microsoft.com/)。  
2. 选择“**添加应用**”。  
3. 为应用输入名称，并选择“**创建应用程序**”。 将显示注册页，其中列出应用的属性。  
4. 在“**平台**”下，选择“**添加平台**”。  
5. 选择“**移动应用程序**”。  
6. 复制客户端 ID（应用 ID）以供后续使用。 将需要在示例应用中输入该值。 应用 ID 是应用的唯一标识符。   
7. 选择“**保存**”。  


<a name="build"></a>
## 构建和调试 ##

1. 克隆该存储库
2. 使用 CocoaPods 以导入 Microsoft Graph SDK 和身份验证依赖项：

        pod 'MSGraphSDK'
        pod 'MSGraphSDK-NXOAuth2Adapter'


 该示例应用已包含可将 pod 导入到项目中的 pod 文件。 只需从**终端**导航到项目并运行：

        pod install

   更多详细信息，请参阅 [其他资源](#其他资源) 中的“**使用 CocoaPods**”

3. 打开 **Graph-iOS-Swift-Snippets.xcworkspace**
4. 打开 **ApplicationConstants.swift** 你会发现，注册过程的 **ClientID** 可以被添加到文件顶部。
   ```swift
   // You will set your application's clientId
   static let clientId = "ENTER_CLIENT_ID"    
   ```
    > 注意：有关使用此示例所需的权限范围的详细信息，请参阅下一节的“**运行示例**”。
5. 运行示例。

## 相关代码
可以在 **Authentication.swift** 中查看所有身份验证代码。 我们使用从 NXOAuth2Client 扩展的 MSAuthenticationProvider 示例实现来提供对已注册的本机应用的登录支持、访问令牌的自动刷新和注销功能。
本示例中使用的客户端 ID 和作用域在 **ApplicationConstants.swift** 中定义。

所有代码段位于项目导航器内的 **Graph-iOS-Swift-Snippets/Snippets** 下。
- **Snippet.swift** 包含在应用中使用的用于构建代码段列表的协议、枚举和结构。
- **UserSnippets.swift** 包含与用户相关的代码段。
- **GroupsSnippets.swift** 包含与组相关的代码段。

## 运行示例

启动时，应用将显示常见用户任务列表。 这些任务可以基于帐户类型和权限级别运行，并在注释中进行了说明：

- 适用于工作或学校以及个人帐户的任务，如接收和发送电子邮件、创建文件等。
- 仅适用于工作或学校帐户的任务，如获取用户的管理器或帐户照片。
- 仅适用于具有管理权限的工作或学校帐户的任务，如获取组成员或新建用户帐户。

选择想要执行的任务并对其单击以运行。 请注意，如果未使用对所选任务适用的权限的帐户进行登录，则会失败。 例如，如果在组织中没有管理员特权的帐户中运行某个特定的代码段（如获取所有租户组），则该操作会失败。 或者，如果使用个人帐户（如 hotmail.com）进行登录并尝试获取登录用户的管理器，则该操作会失败。

目前，该示例应用被配置为位于 ApplicationConstants.swift 中的以下作用域：

    "https://graph.microsoft.com/User.Read",
    "https://graph.microsoft.com/User.ReadWrite",
    "https://graph.microsoft.com/User.ReadBasic.All",
    "https://graph.microsoft.com/Mail.Send",
    "https://graph.microsoft.com/Calendars.ReadWrite",
    "https://graph.microsoft.com/Mail.ReadWrite",
    "https://graph.microsoft.com/Files.ReadWrite",

只需使用上面定义的作用域即可执行多个操作。 但是，某些任务需要管理员权限才能正常运行，且 UI 中的任务将被标记为需要管理员访问权限。 管理员可以将以下作用域添加到 Authentication.constants.m 以运行这些代码段：

    "https://graph.microsoft.com/Directory.AccessAsUser.All",
    "https://graph.microsoft.com/User.ReadWrite.All"
    "https://graph.microsoft.com/Group.ReadWrite.All"

若要查看哪些代码段可以在管理员、组织或个人帐户下运行，请参阅项目导航器内 Graph-iOS-Swift-Snippets/Snippets 下的 UserSnippets.swift 和 GroupsSnippets.swift 文件。 每个代码段说明都将详述访问级别。

<a name="contributing"></a>
## 参与 ##

如果想要参与本示例，请参阅 [CONTRIBUTING.MD](/CONTRIBUTING.md)。

此项目采用 [Microsoft 开源行为准则](https://opensource.microsoft.com/codeofconduct/)。有关详细信息，请参阅 [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/)（行为准则常见问题解答），有任何其他问题或意见，也可联系 [opencode@microsoft.com](mailto:opencode@microsoft.com)。

<a name="questions"></a>
## 问题和意见

我们乐意倾听你有关 Microsoft Graph UWP 代码段库项目的反馈。 你可以在该存储库中的 [问题](https://github.com/microsoftgraph/iOS-objectiveC-snippets-sample/issues) 部分将问题和建议发送给我们。

你的反馈对我们意义重大。 请在 [Stack Overflow](http://stackoverflow.com/questions/tagged/office365+or+microsoftgraph) 上与我们联系。 使用 [MicrosoftGraph] 标记出你的问题。

<a name="additional-resources"></a>
## 其他资源 ##

- [Microsoft Graph 概述](http://graph.microsoft.io)
- [Office 开发人员代码示例](http://dev.office.com/code-samples)
- [Office 开发人员中心](http://dev.office.com/)


## 版权
版权所有 (c) 2016 Microsoft。保留所有权利。