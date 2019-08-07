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
# Exemplo de Trechos de Código do iOS Swift do Microsoft Graph

## Sumário

- [Introdução](#introduction)
- [Pré-requisitos](#prerequisites)
- [Registrar e configurar o aplicativo](#register-and-configure-the-app)
- [Criar e depurar](#build-and-debug)
- [Execução do exemplo](#running-the-sample)

## Introdução

Este exemplo contém um repositório de trechos de código que mostram como usar o SDK do Microsoft Graph SDK para enviar emails, gerenciar grupos e realizar outras atividades com os dados do Office 365. Ele usa o [SDK do Microsoft Graph para iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) para trabalhar com dados retornados pelo Microsoft Graph.

Este repositório mostra como acessar vários recursos, incluindo o Microsoft Azure Active Directory (AD) e APIs do Office 365, fazendo solicitações HTTP para a API do Microsoft Graph em um aplicativo iOS.

Esses trechos são simples e autocontidos e você pode copiá-los e colá-los em seu próprio código, quando apropriado, ou usá-los como um recurso para aprender a usar o SDK do Microsoft Graph para iOS.

**Observação:** Se possível, use este exemplo com uma conta "não comercial" ou de teste. O exemplo nem sempre limpa os objetos criados em sua caixa de correio e calendário. Neste momento, você terá que remover manualmente os exemplos de correios e eventos do calendário. Observe também que os trechos de código que recebem e enviam mensagens e que recebem, criam, atualizam e excluem eventos não funcionarão com todas as contas pessoais. Essas operações eventualmente funcionarão quando essas contas forem atualizadas para funcionar com o ponto de extremidade de autenticação v2.

## Pré-requisitos

Esse exemplo requer o seguinte:

- [Xcode](https://developer.apple.com/xcode/downloads/) versão 10.2.1
- A instalação de [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) como um gerenciador de dependências.
- Uma conta de email comercial ou pessoal da Microsoft como o Office 365, ou outlook.com, hotmail.com, etc. Inscreva-se para uma [Assinatura de Desenvolvedor do Office 365](https://aka.ms/devprogramsignup), que inclui os recursos necessários para começar a criação de aplicativos do Office 365.

## Registrar e configurar o aplicativo

1. Abra um navegador e navegue até o [centro de administração do Azure Active Directory](https://aad.portal.azure.com) e faça logon usando uma **conta pessoal** (também conhecida como: Conta da Microsoft) **Conta Corporativa ou de Estudante**.

1. Selecione **Azure Active Directory** na navegação à esquerda e, em seguida, selecione **Registros de aplicativos** em **Gerenciar**.

1. Selecione **Novo registro**. Na página **Registrar um aplicativo**, defina os valores da seguinte forma.

    - Defina o **Nome** para `Exemplo de Trechos Swift`.
    - Defina **Tipos de contas com suporte** para **Contas em qualquer diretório organizacional e contas pessoais da Microsoft**.
    - Em URI de Redirecionamento, altere a lista suspensa para Cliente público (celular & desktop), e defina o valor como `msauth.com.microsoft.Graph-iOS-Swift-Snippets://auth`.

1. Escolha **Registrar**. Na página **Exemplo de Trechos Swift**, copie o valor da **ID do aplicativo (cliente)** e salve-o, você precisará dele na próxima etapa.

## Criar e depurar

1. Clonar este repositório

1. Abra o **Terminal** e navegue até a raiz do projeto. Execute o seguinte comando para instalar as dependências.

    ```Shell
    pod install
    ```

1. Abra **Graph-Ios-Swift-Snippets. xcworkspace** no Xcode.

1. Abra **ApplicationConstants.swift**. Substitua `ENTER_CLIENT_ID` pela ID do aplicativo obtida do registro de seu aplicativo.

    ```swift
    // You will set your application's clientId
    static let clientId = "ENTER_CLIENT_ID"
    ```

1. Execute o exemplo.

## Execução do exemplo

Após ser iniciado, o aplicativo exibe uma lista de tarefas comuns de usuários. Essas tarefas podem ser executadas com base no nível de permissão e de tipo de conta e trazem uma anotação nos comentários:

- Tarefas que são aplicáveis a contas comerciais ou escolares e contas pessoais, como receber e enviar emails, criar arquivos, etc.
- Tarefas que só são aplicáveis a contas comerciais ou escolares, como receber a foto da conta e o gerenciador do usuário.
- Tarefas que só são aplicáveis a contas comerciais ou escolares com permissões administrativas, como receber membros do grupo ou criar novas contas de usuário.

Escolha a tarefa que você deseja realizar e clique nela para executar. Lembre-se de que se você fizer logon com uma conta que não tem permissões aplicáveis para as tarefas selecionadas, elas falharão. Por exemplo, se você tentar executar um determinado trecho de código, como obter todos os grupos de um locatário, de uma conta que não tem privilégios de administrador na organização, a operação falhará. Ou, se você entrar com uma conta pessoal do e tentar obter o gerenciador do usuário conectado, ele falhará.

## Colaboração

Se quiser contribuir para esse exemplo, confira [CONTRIBUTING.MD](/CONTRIBUTING.md).

Este projeto adotou o [Código de Conduta de Código Aberto da Microsoft](https://opensource.microsoft.com/codeofconduct/).  Para saber mais, confira as [Perguntas frequentes sobre o Código de Conduta](https://opensource.microsoft.com/codeofconduct/faq/) ou entre em contato pelo [opencode@microsoft.com](mailto:opencode@microsoft.com) se tiver outras dúvidas ou comentários.

## Direitos autorais

Copyright © 2016 Microsoft. Todos os direitos reservados.
