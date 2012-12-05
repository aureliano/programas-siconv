# language: pt

Funcionalidade: Acessar sistemas externos através do menu do sítio
  Para integrar o sítio com outros sítios
  Como um usuário do sistema
  Eu desejo navegar por sítios relacionados com o projeto

  Cenário: C1 - Um usuário acessa a página principal do sítio e navega para o portal de convênios
    Dado que eu acesso a página inicial do sistema
    Quando eu clico no link 'Portal de Convênios'
    Então eu devo ver a página inicial do Portal de Convênios - Siconv

  Cenário: C2 - Um usuário acessa a página principal do sítio e navega para a API de dados abertos do Siconv
    Dado que eu acesso a página inicial do sistema
    Quando eu clico no link 'Dados abertos'
    Então eu devo ver a página inicial da API de dados abertos do Siconv
