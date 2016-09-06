# Beispiel für iOS-Swift-Codeausschnitte für Microsoft Graph

**Inhalt**

* [Einführung](#einführung)
* [Anforderungen](#anforderungen)
* [Registrieren und Konfigurieren der App](#registrieren-und-konfigurieren-der-app)
* [Erstellen und Debuggen](#erstellen-und-debuggen)
* [Interessanter Code](#interessanter-code)
* [Ausführen des Beispiels](#ausführen-des-beispiels)
* [Fragen und Kommentare](#fragen-und-kommentare)
* [Weitere Ressourcen](#weitere-ressourcen)

<a name="introduction"></a>
##Einführung

Dieses Beispiel enthält ein Repository von Codeausschnitten, die zeigen, wie das Microsoft Graph-SDK zum Senden von E-Mails, Verwalten von Gruppen und Ausführen anderer Aktivitäten mit Office 365-Daten verwendet wird. Es verwendet das [Microsoft Graph-SDK für iOS](https://github.com/microsoftgraph/msgraph-sdk-ios), um mit Daten zu arbeiten, die von Microsoft Graph zurückgegeben werden.

In diesem Repository wird gezeigt, wie Sie auf mehrere Ressourcen, einschließlich Microsoft Azure Active Directory (AD) und die Office 365-APIs, zugreifen, indem Sie HTTP-Anforderungen an die Microsoft Graph-API in einer iOS-App ausführen. 

Außerdem verwendet das Beispiel [msgraph-sdk-Ios-nxoauth2-adapter](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter) für die Authentifizierung. Um Anforderungen auszuführen, muss ein **MSAuthenticationProvider** bereitgestellt werden, der HTTPS-Anforderungen mit einem entsprechenden OAuth 2.0-Bearertoken authentifizieren kann. Wir verwenden dieses Framework für eine Beispielimplementierung von MSAuthenticationProvider, die Sie für einen Schnelleinstieg in Ihr Projekt verwenden können.

 > Hinweis **msgraph-sdk-ios-nxoauth2-adapter** ist eine Beispielimplementierung von OAuth für die Authentifizierung in dieser App und dient Demonstrationszwecken.

Diese Ausschnitte sind einfach und eigenständig, und Sie können sie ggf. in Ihren eigenen Code kopieren und einfügen oder als Ressource verwenden, um zu lernen, wie das Microsoft Graph-SDK für iOS verwendet wird.

**Hinweis:** Verwenden Sie dieses Beispiel, wenn möglich, mit einem persönlichen Konto oder einem Testkonto. Das Beispiel bereinigt nicht immer die erstellten Objekte in Ihrem Postfach und Kalender. Derzeit müssen Sie Beispiel-E-Mails und -Kalenderereignisse manuell entfernen. Beachten Sie auch, dass die Codeausschnitte, die Nachrichten abrufen und senden und Ereignisse abrufen, erstellen, aktualisieren und löschen, nicht mit allen persönlichen Konten funktionieren. Diese Vorgänge funktionieren dann, wenn diese Konten so aktualisiert werden, dass sie mit dem v2-Authentifizierungsendpunkt arbeiten.

 

<a name="prerequisites"></a>
## Anforderungen ##

Für dieses Beispiel ist Folgendes erforderlich:  
* [Xcode](https://developer.apple.com/xcode/downloads/) von Apple
* Installation von [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) als ein Abhängigkeits-Manager.
* Ein geschäftliches oder persönliches Microsoft-E-Mail-Konto, z. B. Office 365 oder outlook.com, hotmail.com usw. Sie können sich für ein [Office 365-Entwicklerabonnement](https://aka.ms/devprogramsignup) registrieren. Dieses umfasst die Ressourcen, die Sie zum Erstellen von Office 365-Apps benötigen.
* Eine Client-ID aus der registrierten App unter dem [App-Registrierungsportal von Microsoft Graph](https://graph.microsoft.io/en-us/app-registration)
* Wie zuvor erwähnt, muss ein **MSAuthenticationProvider** bereitgestellt werden, der HTTPS-Anforderungen mit einem entsprechenden OAuth 2.0-Bearertoken authentifizieren kann, um Anforderungen auszuführen. 


      
<a name="register"></a>
##Registrieren und Konfigurieren der App

1. Melden Sie sich beim [App-Registrierungsportal](https://apps.dev.microsoft.com/) entweder mit Ihrem persönlichen oder geschäftlichen Konto oder mit Ihrem Schulkonto an.  
2. Klicken Sie auf **App hinzufügen**.  
3. Geben Sie einen Namen für die App ein, und wählen Sie **Anwendung erstellen** aus. Die Registrierungsseite wird angezeigt wird, und die Eigenschaften der App werden aufgeführt.  
4. Wählen Sie unter **Plattformen** die Option **Plattform hinzufügen** aus.  
5. Wählen Sie **Mobile Anwendung** aus.  
6. Kopieren Sie die Client-ID (App-ID) für die spätere Verwendung. Sie müssen diesen Wert in die Beispiel-App eingeben. Die App-ID ist ein eindeutiger Bezeichner für Ihre App.   
7. Klicken Sie auf **Speichern**.  


<a name="build"></a>
## Erstellen und Debuggen ##

1. Klonen dieses Repositorys
2. Verwenden Sie CocoaPods, um das Microsoft Graph-SDK und Authentifizierungsabhängigkeiten zu importieren:

        pod 'MSGraphSDK'
        pod 'MSGraphSDK-NXOAuth2Adapter'


 Diese Beispiel-App enthält bereits eine POD-Datei, die die Pods in das Projekt überträgt. Navigieren Sie einfach über das **Terminal** zum Projekt, und führen Sie Folgendes aus:

        pod install

   Weitere Informationen finden Sie im Thema über das **Verwenden von CocoaPods** in [Zusätzliche Ressourcen](#zusätzliche-ressourcen).

3. Öffnen Sie **Graph-iOS-Swift-Snippets.xcworkspace**.
4. Öffnen Sie **ApplicationConstants.swift**. Sie werden sehen, dass die **ClientID** aus dem Registrierungsprozess am Anfang der Datei hinzugefügt werden kann:
   ```swift
   // You will set your application's clientId
   static let clientId = "ENTER_CLIENT_ID"    
   ```
    > Hinweis: Weitere Informationen zu Berechtigungsbereichen, die für die Verwendung dieses Beispiels erforderlich sind, finden Sie im folgenden Abschnitt **Ausführen des Beispiels**.
5. Führen Sie das Beispiel aus.

## Interessanter Code
Der gesamte Authentifizierungscode kann in der Datei **Authentication.swift** angezeigt werden. Wir verwenden eine Beispielimplementierung von MSAuthenticationProvider, die über „NXOAuth2Client“ hinaus erweitert wurde, um Anmeldeinformationen für registrierte systemeigene Apps, eine automatische Aktualisierung von Zugriffstoken sowie eine Abmeldefunktion bereitzustellen:
Die Client-ID und die Bereiche, die in diesem Beispiel verwendet werden, sind in **ApplicationConstants.swift** definiert.

Alle Codeausschnitte befinden sich unter **Graph-iOS-Swift-Codeausschnitte/Ausschnitte** innerhalb des Projekt-Navigators.
- **Snippet.SWIFT** enthält Protokolle, Enumerationen und Strukturen, die zum Erstellen von Codeausschnittslisten verwendet werden, die in der App verwendet werden sollen.
- **UserSnippets.swift** enthält Ausschnitte im Zusammenhang mit Benutzern.
- **GroupSnippets.swift** enthält Ausschnitte im Zusammenhang mit Gruppen.

## Ausführen des Beispiels

Nach dem Start wird in der App eine Liste allgemeiner Benutzeraufgaben angezeigt. Diese Aufgaben können basierend auf Kontotyp und Berechtigungsstufe ausgeführt werden und werden in Kommentaren notiert.

- Aufgaben, die sowohl für Geschäfts- oder Schulkonten als auch für persönliche Konten gelten, z. B. das Abrufen und Seden von E-Mails, das Erstellen von Dateien usw.
- Aufgaben, die nur für Geschäfts- oder Schulkonten gelten, z. B. das Abrufen eines Vorgesetzten eines Benutzers oder eines Kontofotos.
- Aufgaben, die nur für Geschäfts- oder Schulkonten mit Administratorberechtigungen gelten, z. B. das Abrufen von Gruppenmitgliedern oder das Erstellen neuer Benutzerkonten.

Wählen Sie die Aufgabe aus, die Sie ausführen möchten, und klicken Sie darauf, um sie auszuführen. Beachten Sie, dass die ausgewählten Aufgaben fehlschlagen, wenn Sie sich mit einem Konto anmelden, das nicht über die entsprechenden Berechtigungen für die Aufgaben verfügt. Wenn Sie beispielsweise versuchen, einen bestimmten Ausschnitt, z. B. das Abrufen aller Mandantengruppen, auf einem Konto auszuführen, das nicht über Administratorberechtigungen in der Organisation verfügt, schlägt der Vorgang fehl. Oder wenn Sie sich mit einem persönlichen Konto wie Hotmail.com anmelden und versuchen, den Vorgesetzten des angemeldeten Benutzers abzurufen, schlägt dieser Vorgang fehl.

Diese Beispiel-App ist derzeit mit dem folgenden Bereichen in „ApplicationConstants.swift“ konfiguriert.

    "https://graph.microsoft.com/User.Read",
    "https://graph.microsoft.com/User.ReadWrite",
    "https://graph.microsoft.com/User.ReadBasic.All",
    "https://graph.microsoft.com/Mail.Send",
    "https://graph.microsoft.com/Calendars.ReadWrite",
    "https://graph.microsoft.com/Mail.ReadWrite",
    "https://graph.microsoft.com/Files.ReadWrite",

Indem Sie nur die oben definierten Bereiche verwenden, können Sie mehrere Vorgänge ausführen. Es gibt allerdings einige Vorgänge, für deren ordnungsgemäßes Ausführen Administratorberechtigungen erforderlich sind, und die Aufgaben in der Benutzeroberfläche werden so gekennzeichnet, dass Administratorzugriff erforderlich ist. Administratoren können die folgenden Bereiche zu „Authentication.constants.m“ hinzufügen, um diese Ausschnitte auszuführen:

    "https://graph.microsoft.com/Directory.AccessAsUser.All",
    "https://graph.microsoft.com/User.ReadWrite.All"
    "https://graph.microsoft.com/Group.ReadWrite.All"

Um zu sehen, welche Ausschnitte in einem Administrator- oder Organisationskonto oder in einem persönlichen Konto ausgeführt werden können, sehen Sie sich die Dateien „UserSnippets.swift and GroupsSnippets.swift“ unter „Graph-iOS-Swift-Snippets/Snippets“ im Projekt-Navigator an. In jeder Codeausschnittbeschreibung ist die Zugriffsstufe aufgeführt.

<a name="contributing"></a>
## Mitwirkung ##

Wenn Sie einen Beitrag zu diesem Beispiel leisten möchten, finden Sie unter [CONTRIBUTING.MD](/CONTRIBUTING.md) weitere Informationen.

In diesem Projekt wurden die [Microsoft Open Source-Verhaltensregeln](https://opensource.microsoft.com/codeofconduct/) übernommen. Weitere Informationen finden Sie unter [Häufig gestellte Fragen zu Verhaltensregeln](https://opensource.microsoft.com/codeofconduct/faq/), oder richten Sie Ihre Fragen oder Kommentare an [opencode@microsoft.com](mailto:opencode@microsoft.com).

<a name="questions"></a>
## Fragen und Kommentare

Wir schätzen Ihr Feedback hinsichtlich des Microsoft Graph UWP Snippets Library-Projekts. Sie können uns Ihre Fragen und Vorschläge über den Abschnitt [Probleme](https://github.com/microsoftgraph/iOS-objectiveC-snippets-sample/issues) dieses Repositorys senden.

Ihr Feedback ist uns wichtig. Nehmen Sie unter [Stack Overflow](http://stackoverflow.com/questions/tagged/office365+or+microsoftgraph) Kontakt mit uns auf. Taggen Sie Ihre Fragen mit [MicrosoftGraph].

<a name="additional-resources"></a>
## Weitere Ressourcen ##

- [Microsoft Graph-Übersicht](http://graph.microsoft.io)
- [Office-Entwicklercodebeispiele](http://dev.office.com/code-samples)
- [Office Dev Center](http://dev.office.com/)


## Copyright
Copyright (c) 2016 Microsoft. Alle Rechte vorbehalten.