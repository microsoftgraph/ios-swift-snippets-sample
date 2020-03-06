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
# Microsoft Graph iOS Swift スニペットのサンプル

## 目次

- [はじめに](#introduction)
- [前提条件](#prerequisites)
- [アプリを登録して構成する](#register-and-configure-the-app)
- [ビルドとデバッグ](#build-and-debug)
- [サンプルの実行](#running-the-sample)

## はじめに

このサンプルには、メールの送信、グループの管理、Office 365 データを使用した他のアクティビティの実行に Microsoft Graph SDK を使用する方法を示すコード スニペットのリポジトリが含まれています。[Microsoft Graph SDK for iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) を使用して、Microsoft Graph が返すデータを操作します。

このリポジトリでは、iOS アプリで Microsoft Graph API への HTTP 要求を実行して、Microsoft Azure Active Directory (AD) と Office 365 API などの複数のリソースにアクセスする方法を示します。

これらのスニペットは、簡潔な自己完結型であり、必要に応じて、コピーして独自のコードに貼り付けたり、Microsoft Graph SDK for iOS の使用方法を学習するためのリソースとして使用したりすることができます。

**注:** 可能であれば、"職場以外"のアカウントまたはテスト アカウントでこのサンプルを使用してください。サンプルでは、メールボックスと予定表で作成されたオブジェクトが常にクリーンアップされるとは限りません。現時点では、手動でサンプルのメールと予定表イベントを削除する必要があります。また、メッセージを送受信し、イベントを取得、作成、更新および削除するスニペットは、一部の個人用アカウントでは操作できないことにも注意してください。これらの操作は、それらのアカウントが更新されて v2 認証エンドポイントで操作できるようになったときに、最終的に機能するようになります。

## 前提条件

このサンプルを実行するには次のものが必要です。

- [Xcode](https://developer.apple.com/xcode/downloads/) バージョン 10.2.1
- 依存関係マネージャーとしての [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) のインストール。
- Office 365、outlook.com、hotmail.com などの、Microsoft の職場または個人用のメール アカウント。Office 365 アプリのビルドを開始するために必要なリソースを含む [Office 365 Developer サブスクリプション](https://aka.ms/devprogramsignup)にサインアップできます。

## アプリを登録して構成する

1. ブラウザーを開き、[Azure Active Directory 管理センター](https://aad.portal.azure.com)へ移動して、**個人用アカウント** (別名: Microsoft アカウント)、または**職場/学校アカウント**を使用してログインします。

1. 左側のナビゲーションで **\[Azure Active Directory]** を選択し、それから **\[管理]** で **\[アプリの登録]** を選択します。

1. **\[新規登録]** を選択します。**\[アプリケーションの登録]** ページで、次のように値を設定します。

    - **\[名前]** を `[Swift スニペットのサンプル]` に設定します。
    - **\[サポートされているアカウントの種類]** を **\[任意の組織のディレクトリ内のアカウントと個人用の Microsoft アカウント]** に設定します。
    - **\[リダイレクト URI]** で、ドロップ ダウンを **\[パブリック クライアント (モバイルとデスクトップ)]** に変更し、値を `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth` に設定します。

1. **\[登録]** を選択します。**\[Swift スニペットのサンプル]** ページで、**\[アプリケーション (クライアント) ID]** の値をコピーして保存し、次の手順に移ります。

## ビルドとデバッグ

1. このリポジトリの複製を作成する

1. **\[ターミナル]** を開いて、プロジェクトのルート フォルダーに移動します。次のコマンドを実行して、依存関係をインストールします。

    ```Shell
    pod install
    ```

1. Xcode で **Graph-iOS-Swift-Snippets.xcworkspace** を開きます。

1. **ApplicationConstants.swift** を開きます。`ENTER_CLIENT_ID` を、アプリを登録したときに取得したアプリケーション ID に置き換えます。

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. サンプルを実行します。

## サンプルの実行

起動すると、共通のユーザー タスクの一覧がアプリに表示されます。これらのタスクは、アカウントの種類とアクセス許可のレベルに基づいて実行でき、コメントに記載されています：

- メールの送受信、ファイルの作成など、職場または学校のアカウントおよび個人用アカウントの両方に適用可能なタスク。
- ユーザーの上司またはアカウントの写真の取得など、職場または学校のアカウントにのみ適用可能なタスク。
- グループ メンバーの取得または新しいユーザーの作成など、管理アクセス許可を持つ職場または学校のアカウントにのみ適用可能なタスク。

実行するタスクを選択し、それをクリックして実行します。選択したタスクに適用可能なアクセス許可のないアカウントでログインすると、タスクが失敗しますので注意してください。たとえば、組織内の管理権限のないアカウントからすべてのテナント グループを取得するなど、特定のスニペットを実行しようとすると、その操作は失敗します。または、個人用アカウントでログインしている場合にサインインしているユーザーの上司を取得しようとすると、失敗します。

## 投稿

このサンプルに投稿する場合は、[CONTRIBUTING.MD](/CONTRIBUTING.md) を参照してください。

このプロジェクトでは、[Microsoft オープン ソース倫理規定](https://opensource.microsoft.com/codeofconduct/)が採用されています。詳細については、「[倫理規定の FAQ](https://opensource.microsoft.com/codeofconduct/faq/)」を参照してください。また、その他の質問やコメントがあれば、[opencode@microsoft.com](mailto:opencode@microsoft.com) までお問い合わせください。

## 著作権

Copyright (c) 2016 Microsoft.All rights reserved.
