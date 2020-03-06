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
# Beispiel für iOS-Swift-Codeausschnitte für Microsoft Graph

## Inhaltsverzeichnis

- [Einführung](#introduction)
- [Voraussetzungen](#prerequisites)
- [Registrieren und Konfigurieren der App](#register-and-configure-the-app)
- [Erstellen und Debuggen](#build-and-debug)
- [Ausführen des Beispiels](#running-the-sample)

## Einführung

Dieses Beispiel enthält ein Repository von Codeausschnitten, die zeigen, wie das Microsoft Graph-SDK zum Senden von E-Mails, Verwalten von Gruppen und Ausführen anderer Aktivitäten mit Office 365-Daten verwendet wird. Es verwendet das [Microsoft Graph-SDK für iOS](https://github.com/microsoftgraph/msgraph-sdk-ios), um mit Daten zu arbeiten, die von Microsoft Graph zurückgegeben werden.

In diesem Repository wird gezeigt, wie Sie auf mehrere Ressourcen, einschließlich Microsoft Azure Active Directory (AD) und die Office 365-APIs, zugreifen, indem Sie HTTP-Anforderungen an die Microsoft Graph-API in einer iOS-App ausführen.

Diese Ausschnitte sind einfach und eigenständig, und Sie können sie ggf. in Ihren eigenen Code kopieren und einfügen oder als Ressource verwenden, um zu lernen, wie das Microsoft Graph-SDK für iOS verwendet wird.

**Hinweis:** Verwenden Sie dieses Beispiel, wenn möglich, mit einem persönlichen Konto oder einem Testkonto. Das Beispiel bereinigt nicht immer die erstellten Objekte in Ihrem Postfach und Kalender. Derzeit müssen Sie Beispiel-E-Mails und -Kalenderereignisse manuell entfernen. Beachten Sie auch, dass die Codeausschnitte, die Nachrichten abrufen und senden und Ereignisse abrufen, erstellen, aktualisieren und löschen, nicht mit allen persönlichen Konten funktionieren. Diese Vorgänge funktionieren dann, wenn diese Konten so aktualisiert werden, dass sie mit dem v2-Authentifizierungsendpunkt arbeiten.

## Anforderungen

Für dieses Beispiel ist Folgendes erforderlich:

- [Xcode](https://developer.apple.com/xcode/downloads/), Version 10.2.1
- Installation von [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) als ein Abhängigkeits-Manager.
- Ein geschäftliches oder persönliches Microsoft-E-Mail-Konto, z. B. Office 365 oder outlook.com, hotmail.com usw. Sie können sich für ein [Office 365-Entwicklerabonnement](https://aka.ms/devprogramsignup) registrieren. Dieses umfasst die Ressourcen, die Sie zum Erstellen von Office 365-Apps benötigen.

## Registrieren und Konfigurieren der App

1. Öffnen Sie einen Browser, und navigieren Sie zum [Azure Active Directory Admin Center](https://aad.portal.azure.com). Melden Sie sich mit einem **persönlichen Konto** (auch: Microsoft-Konto) bzw. einem **Geschäfts-, Schul- oder Unikonto** an.

1. Wählen Sie in der linken Navigationsleiste **Azure Active Directory** aus, und wählen Sie dann **App-Registrierungen** unter **Verwalten** aus.

1. Wählen Sie **Neue Registrierungen** aus. Legen Sie auf der Seite **Anwendung registrieren** die Werte wie folgt fest.

    - Legen Sie **Name** auf `Swift-Codeausschnittbeispiel` fest.
    - Legen Sie **Unterstützte Kontotypen** auf **Konten in allen Organisationsverzeichnissen und persönliche Microsoft-Konten** fest.
    - Ändern Sie unter **Umleitungs-URI** die Dropdownliste auf **Öffentlicher Client (mobil & Desktop)**, und legen Sie den Wert auf `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth` fest.

1. Wählen Sie **Registrieren** aus. Kopieren Sie auf der Seite **Swift-Codeausschnittbeispiel** den Wert von **Anwendungs-ID (Client-ID)**, und speichern Sie ihn. Sie benötigen ihn im nächsten Schritt.

## Erstellen und Debuggen

1. Klonen dieses Repositorys

1. Öffnen Sie ein **Terminal**, und navigieren Sie zum Stamm des Projekts. Führen Sie den folgenden Befehl aus, um Abhängigkeiten zu installieren.

    ```Shell
    pod install
    ```

1. Öffnen Sie **Graph-iOS-Swift-Snippets.xcworkspace** in Xcode.

1. Öffnen **Sie ApplicationConstants.swift**. Ersetzen Sie `ENTER_CLIENT_ID` durch die Anwendungs-ID, die Sie durch die Registrierung Ihrer APP erhalten haben.

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. Führen Sie das Beispiel aus.

## Ausführen des Beispiels

Nach dem Start wird in der App eine Liste allgemeiner Benutzeraufgaben angezeigt. Diese Aufgaben können basierend auf Kontotyp und Berechtigungsstufe ausgeführt werden und werden in Kommentaren notiert.

- Aufgaben, die sowohl für Geschäfts- oder Schulkonten als auch für persönliche Konten gelten, z. B. das Abrufen und Seden von E-Mails, das Erstellen von Dateien usw.
- Aufgaben, die nur für Geschäfts- oder Schulkonten gelten, z. B. das Abrufen eines Vorgesetzten eines Benutzers oder eines Kontofotos.
- Aufgaben, die nur für Geschäfts- oder Schulkonten mit Administratorberechtigungen gelten, z. B. das Abrufen von Gruppenmitgliedern oder das Erstellen neuer Benutzerkonten.

Wählen Sie die Aufgabe aus, die Sie ausführen möchten, und klicken Sie darauf, um sie auszuführen. Beachten Sie, dass die ausgewählten Aufgaben fehlschlagen, wenn Sie sich mit einem Konto anmelden, das nicht über die entsprechenden Berechtigungen für die Aufgaben verfügt. Wenn Sie beispielsweise versuchen, einen bestimmten Ausschnitt, z. B. das Abrufen aller Mandantengruppen, auf einem Konto auszuführen, das nicht über Administratorberechtigungen in der Organisation verfügt, schlägt der Vorgang fehl. Oder wenn Sie sich mit einem persönlichen Konto anmelden und versuchen, den Vorgesetzten des angemeldeten Benutzers abzurufen, schlägt dieser Vorgang fehl.

## Mitwirkung

Wenn Sie einen Beitrag zu diesem Beispiel leisten möchten, finden Sie unter [CONTRIBUTING.MD](/CONTRIBUTING.md) weitere Informationen.

In diesem Projekt wurden die [Microsoft Open Source-Verhaltensregeln](https://opensource.microsoft.com/codeofconduct/) übernommen. Weitere Informationen finden Sie unter [Häufig gestellte Fragen zu Verhaltensregeln](https://opensource.microsoft.com/codeofconduct/faq/), oder richten Sie Ihre Fragen oder Kommentare an [opencode@microsoft.com](mailto:opencode@microsoft.com).

## Copyright

Copyright (c) 2016 Microsoft. Alle Rechte vorbehalten.
