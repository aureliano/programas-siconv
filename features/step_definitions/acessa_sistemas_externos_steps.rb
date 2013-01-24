# encoding: utf-8

Então /^eu devo ver a página inicial do Portal de Convênios - Siconv$/ do
  #should have_xpath "//div[@class='page']/div[@class='headInf']/p/a[@href='/siconv/secure/entrar-login.jsp']"
end

Então /^eu devo ver a página inicial da API de dados abertos do Siconv$/ do
  should have_xpath "//h1[@id='site_logo']/a[@href='/']"
  find(:xpath, "//div[@id='barra-brasil']/div/ul/li/a[@title='Acesso à informação']").should have_text 'www.sic.gov.br'
  should have_xpath "//section[@id='apps']/ul/div[@id='myCarousel']/div"
end
