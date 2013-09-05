# language: pt

Funcionalidade: Detalhar dados de um programa do governo federal
  Para exibir os dados de um programa disponibilizado
  Como um usuário do sistema
  Eu desejo obter informações detalhadas sobre o programa

  Contexto:
    Dado que existe o programa '6658947120' disponibilizado '2' dia(s) atrás
    Dado que existe o programa '1154879632' disponibilizado '9' dia(s) atrás
    Dado que existe o programa '1875424879' disponibilizado '5' dia(s) atrás
    Dado que existe o programa '5687745239' disponibilizado '14' dia(s) atrás
    
    Dado que existem '50' programas disponibilizados '23' dia(s) atrás pelo órgão superior 'MINISTERIO DA INTEGRACAO CONTINUA'
    Dado que existem '50' programas disponibilizados '25' dia(s) atrás pelo órgão superior 'MINISTERIO POPULAR'

    Cenário: C1 - Um usuário acessa o sítio e seleciona um programa que está na lista dos programas disponibilizados nos últimos 10 dias.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Disponibilizações' do menu
      E eu verifico os programas disponibilizados nos últimos 10 dias
      Então eu devo ver o total de '3' programas disponibilizados
      
      Quando eu clico no botão 'Detalhar' do programa '1875424879'
      Então eu devo ver a página de detalhamento do programa '1875424879'

    Cenário: C2 - Um usuário acessa o sítio, filtra a lista de programas disponibilizados nos últimos 15 dias e seleciona um programa.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Disponibilizações' do menu
      E eu verifico os programas disponibilizados nos últimos 10 dias
      Então eu devo ver o total de '3' programas disponibilizados
      
      Dado que eu preencho o campo 'dias' com '15'
      Quando eu clico no botão 'Filtrar'
      Então eu devo ver o total de '4' programas disponibilizados
      
      Quando eu clico no botão 'Detalhar' do programa '5687745239'
      Então eu devo ver a página de detalhamento do programa '5687745239'

    Cenário: C3 - Um usuário acessa o sítio, faz uma pesquisa de programas por órgão relacionado e detalha os dados de um programa.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Consulta' do menu
      Então eu devo ver a página de consulta de programas
      
      Dado que eu seleciono o campo 'orgao_superior' com 'MINISTERIO DOS TESTES'
      Quando eu clico no botão 'Consultar'
      Então eu devo ver o resultado da consulta de programas
      E eu devo ver '4' programas no resultado da consulta
      
      Quando eu seleciono o programa '6658947120'
      Então eu devo ver a página de detalhamento do programa '6658947120'

    Cenário: C4 - Um usuário acessa o sítio, faz uma pesquisa de programas e navega até o último programa da lista.
      Dado que existem '954' programas disponibilizados '25' dia(s) atrás pelo órgão superior 'MINISTERIO POPULAR'
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Consulta' do menu
      Então eu devo ver a página de consulta de programas
      
      Dado que eu seleciono o campo 'orgao_superior' com 'MINISTERIO POPULAR'
      Quando eu clico no botão 'Consultar'
      Então eu devo ver o resultado da consulta de programas
      E eu devo ver '1004' programas no resultado da consulta
      
      Quando eu clico no link de paginação '2'
      Então eu devo ver o resultado da consulta de programas na página '2' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>'
      Então eu devo ver o resultado da consulta de programas na página '3' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '<'
      Então eu devo ver o resultado da consulta de programas na página '2' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '12' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '22' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '<<'
      Então eu devo ver o resultado da consulta de programas na página '12' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '22' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '32' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '42' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '52' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '62' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '72' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '82' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '92' com '10' programas num total de '1004'
      
      Quando eu clico no link de paginação '>>'
      Então eu devo ver o resultado da consulta de programas na página '101' com '4' programas num total de '1004'
    
    Cenário: C5 - Um usuário acessa o sítio, faz uma pesquisa de programas expirados por órgão relacionado e detalha os dados de um programa.
      Dado que todos os programas disponibilizados pelo órgão 'MINISTERIO DOS TESTES' estão expirados
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Consulta' do menu
      Então eu devo ver a página de consulta de programas
      
      Dado que eu seleciono o campo 'orgao_superior' com 'MINISTERIO DOS TESTES'
      Quando eu clico no botão 'Consultar'
      Então eu devo ver o resultado da consulta de programas
      E eu devo ver lista de programas vazia
      
      Dado que eu marco o campo 'inclui_programas_expirados'
      Quando eu clico no botão 'Consultar'
      Então eu devo ver '4' programas no resultado da consulta
      
      Quando eu seleciono o programa '6658947120'
      Então eu devo ver a página de detalhamento do programa '6658947120'
