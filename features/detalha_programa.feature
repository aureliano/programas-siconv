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
    Dado que existe o programa '1875424879' disponibilizado '5' dia(s) atrás
    Dado que existe o programa '5548753669' disponibilizado '21' dia(s) atrás
    Dado que existe o programa '4587992125' disponibilizado '90' dia(s) atrás
    Dado que existe o programa '6612455875' disponibilizado '11' dia(s) atrás
    Dado que existe o programa '2000145547' disponibilizado '15' dia(s) atrás
    Dado que existe o programa '7780000002' disponibilizado '51' dia(s) atrás
    Dado que existe o programa '9898954554' disponibilizado '15' dia(s) atrás
    Dado que existe o programa '3326565440' disponibilizado '25' dia(s) atrás

    Cenário: C1 - Um usuário acessa o sítio e seleciona um programa que está na lista dos programas disponibilizados nos últimos 10 dias.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Disponibilizações' do menu
      E eu verifico os programas disponibilizados nos últimos 10 dias
      Então eu devo ver o total de '3' programas disponibilizados
      
      Quando eu clico no botão 'Detalhar' do programa '1875424879'
      Então eu devo ver a página de detalhamento do programa '1875424879'

    Cenário: C2 - Um usuário acessa o sítio, faz uma pesquisa de programas por órgão relacionado e detalha os dados de um programa.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Consulta' do menu
      Então eu devo ver a página de consulta de programas
      
      Dado que eu preencho o campo 'search_params' com 'ministerio testes'
      Quando eu clico no botão 'Consultar'
      Então eu devo ver o resultado da consulta de programas
      E eu devo ver '12' programas no resultado da consulta
      
      Quando eu seleciono o programa '3025781001'
      Então eu devo ver a página de detalhamento do programa '3025781001'
