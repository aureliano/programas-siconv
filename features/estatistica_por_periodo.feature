# language: pt

Funcionalidade: Exibir dados estatísticos de programas do governo federal
  Para exibir os dados estatísticos de programas disponibilizados
  Como um usuário do sistema
  Eu desejo obter informações agregadas dos programas disponibilizados
  
  Contexto:
    Dado que existem '10' programas disponibilizados no ano '2008' e no mês '1'
    Dado que existem '14' programas disponibilizados no ano '2008' e no mês '3'
    Dado que existem '31' programas disponibilizados no ano '2008' e no mês '5'
    Dado que existem '11' programas disponibilizados no ano '2008' e no mês '9'
    Dado que existem '24' programas disponibilizados no ano '2008' e no mês '10'
    Dado que existem '54' programas disponibilizados no ano '2008' e no mês '12'
    
    Dado que existem '8' programas disponibilizados no ano '2009' e no mês '2'
    Dado que existem '78' programas disponibilizados no ano '2009' e no mês '4'
    Dado que existem '65' programas disponibilizados no ano '2009' e no mês '6'
    Dado que existem '56' programas disponibilizados no ano '2009' e no mês '8'
    Dado que existem '45' programas disponibilizados no ano '2009' e no mês '7'
    Dado que existem '43' programas disponibilizados no ano '2009' e no mês '11'
    
    Cenário: C1 - Um usuário acessa o sítio e na seção de dados estatísticos verifica os programas disponibilizados por ano.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Estatísticas' do menu
      Então eu devo ver a página de dados estatísticos
      
      Dado que eu acesso a página de dados estatísticos de programas por período/ano
      Então eu devo ver a página com os dados estatístico de programas por período/ano

    Cenário: C2 - Um usuário acessa o sítio e na seção de dados estatísticos verifica os programas disponibilizados por mês.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Estatísticas' do menu
      Então eu devo ver a página de dados estatísticos
      
      Dado que eu acesso a página de dados estatísticos de programas por período/mês
      Então eu devo ver a página com os dados estatístico de programas por período/mês
      
      Dado que eu seleciono o campo 'ano' com '2009'
      Então eu devo ver o gráfico de programas
