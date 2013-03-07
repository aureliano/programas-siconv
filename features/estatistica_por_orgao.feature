# language: pt

Funcionalidade: Exibir dados estatísticos de programas do governo federal disponibilizados pelos órgãos mandatários
  Para exibir os dados estatísticos de programas disponibilizados
  Como um usuário do sistema
  Eu desejo obter informações agregadas dos programas disponibilizados pelos órgãos superiores

  Contexto:
    Dado que existem '21' programas disponibilizados pelo concedente 'MINISTERIO DOS TESTES' no ano '2008'
    Dado que existem '45' programas disponibilizados pelo concedente 'MINISTERIO DOS TESTES' no ano '2009'
    
    Dado que existem '33' programas disponibilizados pelo concedente 'MINISTERIO DA INTEGRACAO CONTINUA' no ano '2008'
    Dado que existem '15' programas disponibilizados pelo concedente 'MINISTERIO DA INTEGRACAO CONTINUA' no ano '2009'
    
    Dado que existem '47' programas disponibilizados pelo concedente 'MINISTERIO DO BALACOBACO' no ano '2008'
    Dado que existem '88' programas disponibilizados pelo concedente 'MINISTERIO DO BALACOBACO' no ano '2009'
    
    Cenário: C1 - Um usuário acessa o sítio e na seção de dados estatísticos verifica os programas disponibilizados por órgão superior.
      Dado que eu acesso a página inicial do sistema
      Quando eu clico no item 'Estatísticas' do menu
      Então eu devo ver a página de dados estatísticos
      
      Dado que eu acesso a página de dados estatísticos de programas por órgão superior
      Então eu devo ver a página com os dados estatístico de programas por órgão superior
      
      Dado que eu seleciono o campo 'concedentes' com 'MINISTERIO DO BALACOBACO'
      Então eu devo ver o gráfico de programas
