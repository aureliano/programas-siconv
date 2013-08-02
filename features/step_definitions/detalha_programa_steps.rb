# encoding: utf-8

Dado /^que existe o programa '(\d+)' disponibilizado '(\d+)' dia\(s\) atrás$/ do |codigo, dias|
  Programa.create :aceita_emenda_parlamentar => true, :_id => codigo,
                  :data_disponibilizacao => Time.now - (dias.to_i * DAY), :nome => "Programa de Teste #{codigo}",
                  :obriga_plano_trabalho => true, :orgao_superior => 'MINISTERIO DOS TESTES'
end

Dado /^que existem '(\d+)' programas disponibilizados '(\d+)' dia\(s\) atrás pelo órgão superior '([\p{L}\s-]+)'$/ do |total, dias, orgao|
  programas = []
  total.to_i.times do |index|
    codigo = ''
    10.times {|v| codigo << (rand(9) + 1).to_s}

    programas << {
      :aceita_emenda_parlamentar => true, :_id => codigo.to_i,
      :data_disponibilizacao => Time.now - (dias.to_i * DAY), :nome => "Programa de Teste #{codigo}",
      :obriga_plano_trabalho => true, :orgao_superior => orgao
    }
  end
  
  Programa.collection.insert programas  
end

Quando /^eu verifico os programas disponibilizados nos últimos 10 dias$/ do

end

Então /^eu devo ver o total de '(\d+)' programas disponibilizados$/ do |total|
  found = /\d+$/.match(find(:xpath, "//div[@name='div_total_programas']").text).to_s
  total.should eq found
end

Quando /^eu clico no botão 'Detalhar' do programa '(\d+)'$/ do |codigo|
  find(:xpath, "//tr/td[text()='#{codigo}']/../td[4]/a").click
end

Então /^eu devo ver a página de detalhamento do programa '(\d+)'$/ do |codigo|
  alert = page.driver.browser.switch_to.alert
  alert.send('accept')
  
  find(:xpath, "//div[@name='codigo']").text.should eq "Código: #{codigo}"
  should have_text 'Dados do Programa'
  should have_text 'Datas'
  should have_text 'Órgãos Administrativos Relacionados'
end

Então /^eu devo ver a página de consulta de programas$/ do
  should have_xpath "//form/div/select[@id='orgao_superior']"
  should have_button 'Consultar'
end

Então /^eu devo ver o resultado da consulta de programas$/ do
  should have_xpath "//div[@name='div_resultado_consulta']"
end

Então /^eu devo ver '(\d+)' programas no resultado da consulta$/ do |total|
  itens = (total.to_i > 10) ? 10 : total.to_i
  itens += 1 if total.to_i > 10 # total + 1 por causa da div de paginação
  verifica_pagina_resultado_consulta_programas total, itens
end

Quando /^eu seleciono o programa '(\d+)'$/ do |codigo|
  find(:xpath, "//div/a[contains(text(), '#{codigo}')]").click
end

Então /^eu devo ver o resultado da consulta de programas na página '(\d+)' com '(\d+)' programas num total de '(\d+)'$/ do |pagina, itens, total|
  should have_xpath "//div[@class='pagination']/ul/li[@class='disabled']/a[text()='#{pagina}']"
  itens = (itens.to_i + 1) if total.to_i > 10 # total + 1 por causa da div de paginação
  verifica_pagina_resultado_consulta_programas total, itens
end

Quando /^eu clico no link de paginação '([\.\p{L}\s\d-><]+)'$/ do |link|
  find(:xpath, "//div[@class='pagination']/ul/li/a[text()='#{link}']").click
end

def verifica_pagina_resultado_consulta_programas(total, itens)
  should have_text "#{total} item(s) encontrado(s)."
  should have_xpath "//div[@name='div_resultado_consulta']/div", :count => itens
end
