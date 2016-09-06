# Exemplo de Trechos de Código do iOS Swift do Microsoft Graph

**Sumário**

* [Introdução](#introdução)
* [Pré-requisitos](#pré-requisitos)
* [Registrar e configurar o aplicativo](#registrar-e-configurar-o-aplicativo)
* [Compilar e depurar](#compilar-e-depurar)
* [Código de interesse](#código-de-interesse)
* [Execução do exemplo](#execução-do-exemplo)
* [Perguntas e comentários](#perguntas-e-comentários)
* [Recursos adicionais](#recursos-adicionais)

<a name="introduction"></a>
##Introdução

Este exemplo contém um repositório de trechos de código que mostram como usar o SDK do Microsoft Graph SDK enviar emails, gerenciar grupos e realizar outras atividades com os dados do Office 365. O exemplo usa o [SDK do Microsoft Graph para iOS](https://github.com/microsoftgraph/msgraph-sdk-ios) para trabalhar com dados retornados pelo Microsoft Graph.

Este exemplo mostra como acessar vários recursos, incluindo o Microsoft Azure Active Directory (AD) e APIs do Office 365, fazendo solicitações HTTP para a API do Microsoft Graph em um aplicativo iOS. 

Além disso, o exemplo usa [msgraph-sdk-ios-nxoauth2-adapter](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter) para autenticação. Para realizar solicitações de autenticação, um **MSAuthenticationProvider** deve ser fornecido para autenticar solicitações HTTPS com um token de portador OAuth 2.0 apropriado. Usaremos essa estrutura para uma implementação de exemplo de MSAuthenticationProvider que pode ser usada para acelerar seu projeto.

 > **Observação** O adaptador **msgraph-sdk-ios-nxoauth2-adapter** é uma implementação OAuth para autenticação de exemplo neste aplicativo e serve para demonstrações.

Esses trechos são simples e autocontidos e você pode copiá-los e colá-los em seu próprio código, sempre que apropriado, ou usá-los como um recurso para aprender a usar o SDK do Microsoft Graph para iOS.

**Observação:** Se possível, use este exemplo com uma conta "não comercial" ou de teste. O exemplo nem sempre limpa os objetos criados em sua caixa de correio e calendário. Neste momento, você terá que remover manualmente os exemplos de correios e eventos do calendário. Observe também que os trechos de código que recebem e enviam mensagens e que recebem, criam, atualizam e excluem eventos não funcionarão com todas as contas pessoais. Essas operações eventualmente funcionarão quando essas contas forem atualizadas para funcionar com o ponto de extremidade de autenticação v2.

 

<a name="prerequisites"></a>
## Pré-requisitos ##

Este exemplo requer o seguinte:  
* [Xcode](https://developer.apple.com/xcode/downloads/) da Apple
* Instalação do [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) como um gerente de dependências.
* Uma conta de email comercial ou pessoal da Microsoft como o Office 365, ou outlook.com, hotmail.com, etc. Inscreva-se em uma [Assinatura do Office 365 para Desenvolvedor](https://aka.ms/devprogramsignup) que inclua os recursos necessários para começar a criar aplicativos do Office 365.
* Uma ID de cliente do aplicativo registrado no [Portal de Registro do Aplicativo do Microsoft Graph](https://graph.microsoft.io/en-us/app-registration)
* Conforme mencionado acima, para realizar solicitações de autenticação, um **MSAuthenticationProvider** deve ser fornecido para autenticar solicitações HTTPS com um token de portador OAuth 2.0 apropriado. 


      
<a name="register"></a>
##Registrar e configurar o aplicativo

1. Entre no [Portal de Registro do Aplicativo](https://apps.dev.microsoft.com/) usando sua conta pessoal ou sua conta comercial ou escolar.  
2. Selecione **Adicionar um aplicativo**.  
3. Insira um nome para o aplicativo e selecione **Criar aplicativo**. A página de registro é exibida, listando as propriedades do seu aplicativo.  
4. Em **Plataformas**, selecione **Adicionar plataforma**.  
5. Escolha **Aplicativo móvel**.  
6. Copie a ID de Cliente (ID de Aplicativo) para usar posteriormente. Você precisará inserir esse valor no exemplo de aplicativo. Essa ID de aplicativo é o identificador exclusivo do aplicativo.   
7. Selecione **Salvar**.  


<a name="build"></a>
## Compilar e depurar ##

1. Clonar este repositório
2. Use o CocoaPods para importar as dependências de autenticação e o SDK do Microsoft Graph:

        pod 'MSGraphSDK'
        pod 'MSGraphSDK-NXOAuth2Adapter'


 Este aplicativo de exemplo já contém um podfile que colocará os pods no projeto. Simplesmente navegue até o projeto do **Terminal** e execute:

        pod install

   Para saber mais, confira o artigo **Usar o CocoaPods** em [Recursos Adicionais](#recursos-adicionais)

3. Abrir **Graph-iOS-Swift-Snippets.xcworkspace**
4. Abra **ApplicationConstants.swift**. Observe que você pode adicionar o valor de **ID de Cliente** do processo de registro na parte superior do arquivo.
   ```swift
   // You will set your application's clientId
   static let clientId = "ENTER_CLIENT_ID"    
   ```
    > Observação: Para obter mais informações sobre escopos de permissão necessários para usar esse exemplo, consulte a seção **Execução do exemplo** abaixo.
5. Execute o exemplo.

## Código de interesse
Todo código de autenticação pode ser visualizado em **Authentication.swift**. Usamos um exemplo de implementação do MSAuthenticationProvider estendida do NXOAuth2Client para oferecer suporte a login registrados de aplicativos nativos registrados, atualizações automáticas de tokens de acesso e funcionalidade de logout.
A ID de Cliente e os escopos usados neste exemplo são definidos em **ApplicationConstants.swift**.

Todos os trechos de código estão encontram-se em **Graph-iOS-Swift-Snippets/Snippets** no navegador do projeto.
- **Snippet.swift** contém protocolos, enums e estruturas usadas para criar a lista de trechos de código que serão usados no aplicativo.
- **UserSnippets.swift** contém trechos de código relacionados a usuários.
- **GroupsSnippets.swift** contém trechos de código relacionados a grupos.

## Execução do exemplo

Após ser iniciado, o aplicativo exibe uma lista de tarefas comuns de usuários. Essas tarefas podem ser executadas com base no nível de permissão e de tipo de conta e trazem uma anotação nos comentários:

- Tarefas que são aplicáveis a contas comerciais ou escolares e contas pessoais, como receber e enviar emails, criar arquivos, etc.
- Tarefas que só são aplicáveis a contas comerciais ou escolares, como receber a foto da conta e o gerenciador do usuário.
- Tarefas que só são aplicáveis a contas comerciais ou escolares com permissões administrativas, como receber membros do grupo ou criar novas contas de usuário.

Escolha a tarefa que você deseja realizar e clique nela para executar. Lembre-se de que se você fizer logon com uma conta que não tem permissões aplicáveis para as tarefas selecionadas, elas falharão. Por exemplo, se você tentar executar um determinado trecho de código, como obter todos os grupos de um locatário, de uma conta que não tem privilégios de administrador na organização, a operação falhará. Ou, se você fizer logon usando uma conta pessoal, como hotmail.com, e tentar obter o gerenciador do usuário conectado, a operação falhará.

No momento, este exemplo de aplicativo está configurado com os seguintes escopos localizados em ApplicationConstants.swift:

    "https://graph.microsoft.com/User.Read",
    "https://graph.microsoft.com/User.ReadWrite",
    "https://graph.microsoft.com/User.ReadBasic.All",
    "https://graph.microsoft.com/Mail.Send",
    "https://graph.microsoft.com/Calendars.ReadWrite",
    "https://graph.microsoft.com/Mail.ReadWrite",
    "https://graph.microsoft.com/Files.ReadWrite",

Você poderá realizar várias operações usando apenas os escopos definidos acima. No entanto, há algumas tarefas que exigem privilégios de administrador para serem executadas corretamente. Além disso, as tarefas na interface de usuário serão marcadas como precisando de acesso de administrador. Os administradores podem adicionar os seguintes escopos a Authentication.constants.m para executar esses trechos de código:

    "https://graph.microsoft.com/Directory.AccessAsUser.All",
    "https://graph.microsoft.com/User.ReadWrite.All"
    "https://graph.microsoft.com/Group.ReadWrite.All"

Para ver quais trechos podem ser executados em contas de administrador, da organização ou pessoais, consulte arquivos UserSnippets.swift e GroupsSnippets.swift em Graph-iOS-Swift-Snippets/Snippets no navegador do projeto. A descrição de cada trecho de código detalhará o nível de acesso.

<a name="contributing"></a>
## Colaboração ##

Se quiser contribuir para esse exemplo, confira [CONTRIBUTING.MD](/CONTRIBUTING.md).

Este projeto adotou o [Código de Conduta do Código Aberto da Microsoft](https://opensource.microsoft.com/codeofconduct/). Para saber mais, confira as [Perguntas frequentes do Código de Conduta](https://opensource.microsoft.com/codeofconduct/faq/) ou contate [opencode@microsoft.com](mailto:opencode@microsoft.com) se tiver outras dúvidas ou comentários.

<a name="questions"></a>
## Perguntas e comentários

Adoraríamos receber seus comentários sobre o projeto Biblioteca de Trechos de Código do UWP do Microsoft Graph. Você pode nos enviar suas perguntas e sugestões por meio da seção [Issues](https://github.com/microsoftgraph/iOS-objectiveC-snippets-sample/issues) deste repositório.

Seus comentários são importantes para nós. Junte-se a nós na página [Stack Overflow](http://stackoverflow.com/questions/tagged/office365+or+microsoftgraph). Marque suas perguntas com [MicrosoftGraph].

<a name="additional-resources"></a>
## Recursos adicionais ##

- [Visão geral do Microsoft Graph](http://graph.microsoft.io)
- [Exemplos de código para desenvolvedores do Office](http://dev.office.com/code-samples)
- [Centro de desenvolvimento do Office](http://dev.office.com/)


## Direitos autorais
Copyright © 2016 Microsoft. Todos os direitos reservados.