# encoding: utf-8

Então /^eu devo ver a página inicial do Portal de Convênios - Siconv$/ do
  has_xpath? "//div[@class='page']/div[@class='headInf']/p/a[@href='/siconv/secure/entrar-login.jsp']"
end

Então /^eu devo ver a página inicial da API de dados abertos do Siconv$/ do
  has_xpath? "//div[@id='topo']/h1[text() = 'Dados Abertos SICONV']"
  has_xpath? "header/div/ul/li/a[text() = 'Início']"
  has_xpath? "header/div/ul/li/a[text() = 'Lista de Métodos']"
end
