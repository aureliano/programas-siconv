# language: pt

Funcionalidade: Log de versões do sítio
  Para verificar as alterações no sítio
  Como um usuário do sistema
  Eu desejo conhecer todas as novas funcionalidades ou correções do sítio

  Cenário: C1 - Um usuário acessa a página de log da versão atual do sítio
    Dado que eu acesso a página inicial do sistema
    Quando eu clico no link de versão do sítio
    Então eu devo ver a página com as mudanças da versão atual

  Cenário: C2 - Um usuário acessa a página com o log de todas as versões do sítio
    Dado que eu acesso a página inicial do sistema
    Quando eu clico no link de versão do sítio
    Então eu devo ver a página com as mudanças da versão atual
    
    Quando eu clico no link 'Ver log completo...'
    Então eu devo ver a página com as mudanças de todas as versões
