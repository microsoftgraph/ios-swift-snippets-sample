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
# Ejemplo de fragmentos de código de muestra de iOS en Swift de Microsoft Graph

## Tabla de contenido

- [Introducción](#introduction)
- [Requisitos previos](#prerequisites)
- [Registrar y configurar la aplicación](#register-and-configure-the-app)
- [Compilar y depurar](#build-and-debug)
- [Ejecución del ejemplo](#running-the-sample)

## Introducción

Este ejemplo contiene un repositorio de fragmentos de código que muestran cómo usar el SDK de Microsoft Graph para enviar correos electrónicos, administrar grupos y realizar otras actividades con los datos de Office 365. Usa el [SDK de Microsoft Graph para iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) para trabajar con los datos devueltos por Microsoft Graph.

Este repositorio muestra cómo tener acceso a varios recursos, incluidos Microsoft Azure Active Directory (AD) y las API de Office 365, realizando solicitudes HTTP a la API de Microsoft Graph en una aplicación de iOS.

Estos fragmentos de código son simples e independientes, y puede copiarlos y pegarlos en su propio código, cuando sea apropiado, o usarlos como un recurso para aprender a usar el SDK de Microsoft Graph para iOS.

**Nota:** Si es posible, use este ejemplo con una cuenta de prueba o "no profesional". El ejemplo no siempre limpia los objetos creados en el buzón de correo y el calendario. En este momento, tendrá que eliminar manualmente los eventos del calendario y los correos del ejemplo. Tenga en cuenta que los fragmentos de código que reciben y envían mensajes, y que obtienen, crean, actualizan y eliminan eventos no funcionarán con todas las cuentas personales. Estas operaciones funcionarán finalmente cuando esas cuentas se actualicen para su funcionamiento con el modelo de autenticación v2.

## Requisitos previos

Este ejemplo necesita lo siguiente:

- La versión 10.2.1 de [Xcode](https://developer.apple.com/xcode/downloads/)
- La instalación de [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) como administrador de dependencias.
- Una cuenta de correo electrónico personal o profesional de Microsoft como Office 365, outlook.com, hotmail.com, etc. Puede realizar [una suscripción a Office 365 Developer](https://aka.ms/devprogramsignup) que incluye los recursos que necesita para comenzar a crear aplicaciones de Office 365.

## Registrar y configurar la aplicación

1. Abra un explorador y vaya al [Centro de administración de Azure Active Directory](https://aad.portal.azure.com) e inicie sesión con una **cuenta personal** (también conocida como: una cuenta de Microsoft) o una **cuenta profesional o educativa**.

1. Seleccione **Azure Active Directory** en el panel de navegación izquierdo y, después, **Registros de aplicaciones** en **Administrar**.

1. Seleccione **Nuevo registro**. En la página **Registrar una aplicación**, establezca los valores siguientes.

    - Establezca el **Nombre** en `Ejemplo de fragmentos de código de Swift`.
    - Establezca **Tipos de cuenta admitidos** en **Cuentas en cualquier directorio de organización y cuentas personales de Microsoft**.
    - En **URI de redirección**, cambie la lista desplegable a **Cliente público (móvil y escritorio)** y establezca el valor en `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth`.

1. Elija **Registrar**. En la página **Ejemplo de fragmentos de código de Swift**, copie el valor del **Id. de aplicación (cliente)** y guárdelo. Lo necesitará en el paso siguiente.

## Compilar y depurar

1. Clone este repositorio.

1. Abra el **Terminal** y desplácese hasta la raíz del proyecto. Ejecute el siguiente comando para instalar dependencias.

    ```Shell
    pod install
    ```

1. Abra **Graph-iOS-Swift-Snippets.xcworkspace** en Xcode.

1. Abra **ApplicationConstants.swift**. Reemplace `ESCRIBIR_ID_CLIENTE` por el id. de la aplicación que obtuvo al registrar la aplicación.

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. Ejecute el ejemplo.

## Ejecución del ejemplo

Al iniciarse, la aplicación muestra una lista de tareas de usuario comunes. Estas tareas se pueden ejecutar basándose en el tipo de cuenta y nivel de permiso, y están marcadas en comentarios:

- Tareas que son aplicables a cuentas profesionales, educativas y personales, como recibir y enviar correo electrónico, crear archivos, etc.
- Tareas que solamente son aplicables a cuentas profesionales o educativas, como obtener fotos de administrador o de la cuenta de un usuario.
- Tareas que solo son aplicables a una cuenta profesional o educativa con permisos administrativos, como obtener miembros del grupo o crear nuevas cuentas de usuario.

Seleccione la tarea que desea realizar y haga clic en ella para ejecutarla. Tenga en cuenta que, si inicia una sesión con una cuenta que no tiene permisos aplicables para las tareas que ha seleccionado, no se realizarán correctamente. Por ejemplo, si intenta ejecutar un fragmento de código determinado, como obtener todos los grupos del inquilino a partir de una cuenta que no tiene privilegios de administrador en la organización, se producirá un error en la operación. Si inicia una sesión con una cuenta personal e intenta obtener el administrador del usuario con la sesión iniciada, se producirá un error.

## Colaboradores

Si le gustaría contribuir a este ejemplo, vea [CONTRIBUTING.MD](/CONTRIBUTING.md).

Este proyecto ha adoptado el [Código de conducta de código abierto de Microsoft](https://opensource.microsoft.com/codeofconduct/). Para obtener más información, vea [Preguntas frecuentes sobre el código de conducta](https://opensource.microsoft.com/codeofconduct/faq/) o póngase en contacto con [opencode@microsoft.com](mailto:opencode@microsoft.com) si tiene otras preguntas o comentarios.

## Copyright

Copyright (c) 2016 Microsoft. Todos los derechos reservados.
