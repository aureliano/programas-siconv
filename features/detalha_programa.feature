# language: pt

Funcionalidade: Detalhar dados de um programa do governo federal
  Para exibir os dados de um programa disponibilizado
  Como um usuário do sistema
  Eu desejo obter informações detalhadas sobre o programa

  Contexto:
    Dado que existe o programa '6658947120' disponibilizado '2' dia(s) atrás
    Dado que existe o programa '1154879632' disponibilizado '9' dia(s) atrás
    Dado que existe o programa '8896345784' disponibilizado '10' dia(s) atrás
    Dado que existe o programa '3025781001' disponibilizado '15' dia(s) atrás
    Dado que existe o programa '0875424879' disponibilizado '5' dia(s) atrás

    Cenário: C1 - Um usuário acessa o sítio e seleciona um programa que está na lista dos programas disponibilizados nos últimos 10 dias
      Dado que eu acesso a página inicial do sistema
      Quando eu verifico os programas disponibilizados nos últimos 10 dias
      Então eu devo ver o total de '3' programas disponibilizados
      
      Quando eu clico no botão 'Detalhar' do programa '0875424879'
      Então eu devo ver a página de detalhamento do programa '0875424879'
