# Microsoft Graph iOS Swift スニペットのサンプル

**目次**

* [はじめに](#はじめに)
* [前提条件](#前提条件)
* [アプリを登録して構成する](#アプリを登録して構成する)
* [ビルドとデバッグ](#ビルドとデバッグ)
* [目的のコード](#目的のコード)
* [サンプルの実行](#サンプルの実行)
* [質問とコメント](#質問とコメント)
* [その他のリソース](#その他のリソース)

<a name="introduction"></a>
##はじめに

このサンプルには、メールの送信、グループの管理、および Office 365 データを使用した他のアクティビティの実行に Microsoft Graph SDK を使用する方法を示すコード スニペットのリポジトリが含まれています。 [Microsoft Graph SDK for iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) を使用して、Microsoft Graph が返すデータを操作します。

このリポジトリでは、iOS アプリで Microsoft Graph API への HTTP 要求を実行して、Microsoft Azure Active Directory (AD) と Office 365 API などの複数のリソースにアクセスする方法を示します。 

また、サンプルでは認証に [msgraph-sdk-ios-nxoauth2-adapter](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter) を使用します。 要求を実行するには、適切な OAuth 2.0 ベアラー トークンを使用して HTTPS 要求を認証できる **MSAuthenticationProvider** を指定する必要があります。 プロジェクトのジャンプ スタート用に使用できる MSAuthenticationProvider をサンプル実装するために、このフレームワークを使用します。

 > **注** **msgraph-sdk-ios-nxoauth2-adapter** は、このアプリでの認証用の OAuth のサンプル実装であり、デモンストレーションを目的としています。

これらのスニペットは、簡潔な自己完結型であり、必要に応じて、コピーして独自のコードに貼り付けたり、Microsoft Graph SDK for iOS の使用方法を学習するためのリソースとして使用したりすることができます。

**注:**可能であれば、"職場以外"のアカウントまたはテスト アカウントでこのサンプルを使用してください。 サンプルでは、メールボックスと予定表で作成されたオブジェクトが常にクリーンアップされるとは限りません。 現時点では、手動でサンプルのメールと予定表イベントを削除する必要があります。 また、メッセージを送受信し、イベントを取得、作成、更新および削除するスニペットは、一部の個人用アカウントでは操作できないことにも注意してください。 これらの操作は、それらのアカウントが更新されて v2 認証エンドポイントで操作できるようになったときに、最終的に機能するようになります。

 

<a name="prerequisites"></a>
## 前提条件 ##

このサンプルを実行するには次のものが必要です:  
* Apple 社の [Xcode](https://developer.apple.com/xcode/downloads/)
* 依存関係マネージャーとしての [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) のインストール。
* Office 365、outlook.com、hotmail.com などの、Microsoft の職場または個人用のメール アカウント。Office 365 アプリのビルドを開始するために必要なリソースを含む、[Office 365 Developer サブスクリプション](https://aka.ms/devprogramsignup)にサインアップできます。
* [Microsoft Graph アプリ登録ポータル](https://graph.microsoft.io/en-us/app-registration) で登録済みのアプリのクライアント ID
* 前述のように、認証要求を実行するには、適切な OAuth 2.0 ベアラー トークンを使用して HTTPS 要求を認証できる **MSAuthenticationProvider** を指定する必要があります。 


      
<a name="register"></a>
##アプリを登録して構成する

1. 個人用アカウント、あるいは職場または学校アカウントのいずれかを使用して、[アプリ登録ポータル](https://apps.dev.microsoft.com/)にサインインします。  
2. **[アプリの追加]** を選択します。  
3. アプリの名前を入力して、**[アプリケーションの作成]** を選択します。 登録ページが表示され、アプリのプロパティが一覧表示されます。  
4. **[プラットフォーム]** で、**[プラットフォームの追加]** を選択します。  
5. **[モバイル アプリケーション]** を選択します。  
6. 後で使用するために、クライアント ID (アプリ ID) をコピーします。 サンプル アプリにこの値を入力する必要があります。 アプリ ID は、アプリの一意識別子です。   
7. **[保存]** を選択します。  


<a name="build"></a>
## ビルドとデバッグ ##

1. このリポジトリの複製を作成する
2. CocoaPods を使用して、Microsoft Graph SDK と認証の依存関係をインポートします:

        pod 'MSGraphSDK'
        pod 'MSGraphSDK-NXOAuth2Adapter'


 このサンプル アプリには、プロジェクトに pod を取り込む podfile が既に含まれています。 **ターミナル**からプロジェクトに移動して次を実行するだけです:

        pod install

   詳細については、[その他の技術情報](#その他の技術情報)の「**CocoaPods を使う**」を参照してください

3. **Graph-iOS-Swift-Snippets.xcworkspace** を開きます
4. **ApplicationConstants.swift** を開きます。 登録プロセスの **ClientID** がファイルの一番上に追加されていることが分かります。:
   ```swift
   // You will set your application's clientId
   static let clientId = "ENTER_CLIENT_ID"    
   ```
    > 注:このサンプルを使用するために必要なアクセス許可の適用範囲の詳細については、以下の「**サンプルの実行**」セクションをご覧ください。
5. サンプルを実行します。

## 目的のコード
すべての認証コードは、**Authentication.swift** で確認することができます。 NXOAuth2Client から拡張された MSAuthenticationProvider のサンプル実装を使用して、登録済みのネイティブ アプリのログインのサポート、アクセス トークンの自動更新、およびログアウト機能を提供します。
このサンプルで使用するクライアント ID と適用範囲は、**ApplicationConstants.swift** で定義されます。

すべてのスニペットは、プロジェクト ナビゲーター内の **Graph-iOS-Swift-Snippets/Snippets** の下にあります。
- **Snippet.swift** には、アプリで使用されるスニペットの一覧を構築するために使用するプロトコル、列挙型、および構造体が含まれています。
- **UserSnippets.swift** には、ユーザーに関連するスニペットが含まれています。
- **GroupsSnippets.swift** には、グループに関連するスニペットが含まれています。

## サンプルの実行

起動すると、共通のユーザー タスクの一覧がアプリに表示されます。 これらのタスクは、アカウントの種類とアクセス許可のレベルに基づいて実行でき、コメントに記載されています：

- メールの送受信、ファイルの作成など、職場または学校のアカウントおよび個人用アカウントの両方に適用可能なタスク。
- ユーザーの上司またはアカウントの写真の取得など、職場または学校のアカウントにのみ適用可能なタスク。
- グループ メンバーの取得または新しいユーザーの作成など、管理アクセス許可を持つ職場または学校のアカウントにのみ適用可能なタスク。

実行するタスクを選択し、それをクリックして実行します。 選択したタスクに適用可能なアクセス許可のないアカウントでログインすると、タスクが失敗しますので注意してください。 たとえば、組織内の管理権限のないアカウントからすべてのテナント グループを取得するなど、特定のスニペットを実行しようとすると、その操作は失敗します。 または、hotmail.com などの個人用アカウントでログインしている場合にサインインしているユーザーの上司を取得しようとすると、失敗します。

現在、このサンプル アプリは ApplicationConstants.swift にある次の適用範囲で構成されています:

    "https://graph.microsoft.com/User.Read",
    "https://graph.microsoft.com/User.ReadWrite",
    "https://graph.microsoft.com/User.ReadBasic.All",
    "https://graph.microsoft.com/Mail.Send",
    "https://graph.microsoft.com/Calendars.ReadWrite",
    "https://graph.microsoft.com/Mail.ReadWrite",
    "https://graph.microsoft.com/Files.ReadWrite",

上記で定義された適用範囲を使用するだけで、複数の操作を実行することができます。 ただし、適切に実行するために管理権限を必要とするタスクも一部あり、そのタスクは UI 上で管理者アクセスが必要であるとしてマークされます。 管理者は、次の適用範囲を Authentication.constants.m に追加して、これらのスニペットを実行できる場合があります:

    "https://graph.microsoft.com/Directory.AccessAsUser.All",
    "https://graph.microsoft.com/User.ReadWrite.All"
    "https://graph.microsoft.com/Group.ReadWrite.All"

管理者、組織、または個人の各アカウントに対して実行できるスニペットを確認するには、プロジェクト ナビゲーター内の Graph-iOS-Swift-Snippets/Snippets の下にある UserSnippets.swift ファイルと GroupsSnippets.swift ファイルを参照してください。 各スニペットの説明は、アクセスのレベルについて詳しく説明しています。

<a name="contributing"></a>
## 投稿 ##

このサンプルに投稿する場合は、[CONTRIBUTING.MD](/CONTRIBUTING.md) を参照してください。

このプロジェクトでは、[Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/) が採用されています。詳細については、「[規範に関する FAQ](https://opensource.microsoft.com/codeofconduct/faq/)」を参照してください。または、その他の質問やコメントがあれば、[opencode@microsoft.com](mailto:opencode@microsoft.com) までにお問い合わせください。

<a name="questions"></a>
## 質問とコメント

Microsoft Graph UWP スニペット ライブラリ プロジェクトに関するフィードバックをお寄せください。 質問や提案につきましては、このリポジトリの「[問題](https://github.com/microsoftgraph/iOS-objectiveC-snippets-sample/issues)」セクションで送信できます。

お客様からのフィードバックを重視しています。 [スタック オーバーフロー](http://stackoverflow.com/questions/tagged/office365+or+microsoftgraph)でご連絡いただけます。 ご質問には [MicrosoftGraph] のタグを付けてください。

<a name="additional-resources"></a>
## その他のリソース ##

- [Microsoft Graph の概要](http://graph.microsoft.io)
- [Office 開発者向けコード サンプル](http://dev.office.com/code-samples)
- [Office デベロッパー センター](http://dev.office.com/)


## 著作権
Copyright (c) 2016 Microsoft. All rights reserved.