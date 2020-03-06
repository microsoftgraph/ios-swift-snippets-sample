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
# Exemple d’extraits de code Microsoft Graph iOS Swift

## Table des matières

- [Introduction](#introduction)
- [Conditions préalables](#prerequisites)
- [Enregistrement et configuration de l’application](#register-and-configure-the-app)
- [Création et débogage](#build-and-debug)
- [Exécution de l’exemple](#running-the-sample)

## Introduction

Cet exemple contient un référentiel des extraits de code qui illustrent l’utilisation du kit de développement Microsoft Graph pour envoyer des messages électroniques, gérer les groupes et effectuer d’autres activités avec les données d’Office 365. Il utilise le [kit de développement logiciel Microsoft Graph pour iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) pour exploiter les données renvoyées par Microsoft Graph.

Ce référentiel vous montre comment accéder à plusieurs ressources, notamment Microsoft Azure Active Directory (AD) et les API d’Office 365, en envoyant des requêtes HTTP à l’API Microsoft Graph dans une application iOS.

Ces extraits sont simples et autonomes, et vous pouvez les copier-coller dans votre propre code, le cas échéant, ou les utiliser comme ressource d’apprentissage sur l’utilisation du kit de développement logiciel Microsoft Graph pour iOS.

**Remarque :** Si possible, utilisez cet exemple avec un compte de test ou non professionnel. L’exemple ne nettoie pas toujours les objets créés dans votre boîte aux lettres et votre calendrier. À ce stade, vous devrez supprimer manuellement les exemples de messages électroniques et les événements de calendrier. Notez également que les extraits de code qui obtiennent et envoient des messages et qui obtiennent, créent, mettent à jour et suppriment des événements ne fonctionnent pas avec tous les comptes personnels. Ces opérations fonctionneront finalement lorsque ces comptes seront mis à jour pour fonctionner avec le point de terminaison d’authentification v2.

## Conditions préalables

Cet exemple nécessite les éléments suivants :

- [Xcode](https://developer.apple.com/xcode/downloads/) version 10.2.1
- Installation de [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) comme gestionnaire de dépendances.
- Un compte de messagerie professionnel ou personnel Microsoft comme Office 365 ou outlook.com, hotmail.com, etc. Vous pouvez vous inscrire à [Office 365 Developer](https://aka.ms/devprogramsignup) pour accéder aux ressources dont vous avez besoin pour commencer à créer des applications Office 365.

## Enregistrement et configuration de l’application

1. Ouvrez un navigateur, accédez au [Centre d’administration Azure Active Directory](https://aad.portal.azure.com) et connectez-vous à l’aide d’un **compte personnel** (ou compte Microsoft) ou d’un **compte professionnel ou scolaire**.

1. Sélectionnez **Azure Active Directory** dans le volet de navigation gauche, puis sélectionnez **Inscriptions d’applications** sous **Gérer**.

1. Sélectionnez **Nouvelle inscription**. Sur la page **Inscrire une application**, définissez les valeurs comme suit.

    - Définissez **Nom** sur `Exemple d'extraits de code Swift`.
    - Définissez **Types de comptes pris en charge** sur **Comptes figurant dans un annuaire organisationnel et comptes Microsoft personnels**.
    - Sous **URI de redirection**, remplacez la liste déroulante par **client public (mobile et bureau)** et définissez la valeur sur `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth`.

1. Choisissez **Inscrire**. Dans la page **Exemple d’extraits de code Swift**, copiez la valeur de **ID d’application (client)** et enregistrez-la, car vous en aurez besoin à l’étape suivante.

## Création et débogage

1. Cloner ce référentiel

1. Ouvrez **Terminal** et accédez au dossier racine du projet. Exécutez la commande suivante pour installer les dépendances.

    ```Shell
    pod install
    ```

1. Ouvrez **Graph-iOS-Swift-Snippets.xcworkspace** dans Xcode.

1. Ouvrez **ApplicationConstants.swift**. Remplacez `ENTER_CLIENT_ID` par l’ID d’application que vous avez obtenu de l’inscription de votre application.

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. Exécutez l’exemple.

## Exécution de l’exemple

Une fois lancée, l’application affiche une liste de tâches courantes de l’utilisateur. Ces tâches peuvent être exécutées en fonction du niveau d’autorisations et du type de compte et sont indiquées dans les commentaires :

- Tâches qui s’appliquent à la fois aux comptes professionnels, scolaires et personnels, telles que l’obtention et l’envoi de messages électroniques, la création de fichiers, etc.
- Tâches qui s’appliquent uniquement aux comptes professionnels ou scolaires, telles que l’obtention de la photo de compte ou du responsable d’un utilisateur.
- Tâches qui s’appliquent uniquement aux comptes professionnels ou scolaires avec des autorisations administratives appropriées, telles que l’obtention de membres du groupe ou la création de comptes d’utilisateur.

Sélectionnez la tâche que vous souhaitez effectuer et cliquez dessus pour l’exécuter. N’oubliez pas que si vous vous connectez avec un compte qui ne dispose pas des autorisations applicables pour les tâches sélectionnées, celles-ci échoueront. Par exemple si vous essayez d’exécuter un extrait spécifique, tel que l’obtention de tous les groupes du client, à partir d’un compte qui ne dispose pas de privilèges d’administrateur dans l’organigramme, l’opération échoue. Sinon, si vous vous connectez avec un compte personnel comme hotmail.com et essayez d’obtenir le responsable de l’utilisateur connecté, l’opération échoue.

## Contribution

Si vous souhaitez contribuer à cet exemple, voir [CONTRIBUTING.MD](/CONTRIBUTING.md).

Ce projet a adopté le [code de conduite Open Source de Microsoft](https://opensource.microsoft.com/codeofconduct/). Pour en savoir plus, reportez-vous à la [FAQ relative au code de conduite](https://opensource.microsoft.com/codeofconduct/faq/) ou contactez [opencode@microsoft.com](mailto:opencode@microsoft.com) pour toute question ou tout commentaire.

## Copyright

Copyright (c) 2016 Microsoft. Tous droits réservés.
