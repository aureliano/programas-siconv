# encoding: utf-8

Então /^eu devo ver a página inicial do Portal de Convênios - Siconv$/ do
  should have_xpath "//div[@class='page']/div[@class='headInf']/p/a[@href='/siconv/secure/entrar-login.jsp']"
end

Então /^eu devo ver a página inicial da API de dados abertos do Siconv$/ do
  should have_xpath "//div[@id='topo']/h1[text() = 'Dados Abertos SICONV']"
  find(:xpath, "//header/div/ul/li/a[@href='index.html']").should have_text 'Início'
  find(:xpath, "//header/div/ul/li/a[@href='metodos.html']").should have_text 'Lista de Métodos'
end

Então /^eu devo ver a página de consulta de Programas do Siconv$/ do
  find(:xpath, "//span[@class='exit']").should have_text 'Entrar no sistema com senha'
  find(:xpath, "//div[@id='userCase']/h2").should have_text 'Consultar Programas'
end
