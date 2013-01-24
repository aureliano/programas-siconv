# encoding: utf-8

Dado /^que existe o programa '(\d+)' disponibilizado '(\d+)' dia\(s\) atrás$/ do |codigo, dias|
  Programa.create :aceita_emenda_parlamentar => true, :_id => codigo,
                  :data_disponibilizacao => Time.now - (dias.to_i * DAY), :nome => "Programa de Teste #{codigo}",
                  :obriga_plano_trabalho => true, :orgao_executor => 'MINISTERIO DOS TESTES', :tags => ['ministerio', 'testes']
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
  should have_xpath "//form/div/input[@id='search_params']"
  should have_button 'Consultar'
end

Então /^eu devo ver o resultado da consulta de programas$/ do
  should have_xpath "//div[@name='div_resultado_consulta']"
end

Então /^eu devo ver '(\d+)' programas no resultado da consulta$/ do |total|
  should have_text "#{total} item(s) encontrado(s)."
  divs = 10 if total.to_i > 10
  should have_xpath "//div[@name='div_resultado_consulta']/div", :count => (divs + 1) # total + 1 por causa da div de paginação
end

Quando /^eu seleciono o programa '(\d+)'$/ do |codigo|
  find(:xpath, "//div/a[contains(text(), '#{codigo}')]").click
end
