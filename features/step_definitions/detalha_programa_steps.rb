# encoding: utf-8

Dado /^que existe o programa '(\d+)' disponibilizado '(\d+)' dia\(s\) atrás$/ do |codigo, dias|
  Programa.create :aceita_emenda_parlamentar => true, :cod_programa_siconv => codigo,
                  :data_disponibilizacao => Time.now - (dias.to_i * DAY), :nome => 'Programa de Teste 1 ',
                  :obriga_plano_trabalho => true, :orgao_executor => 'MINISTERIO DOS TESTES', :tags => ['ministerio', 'testes']
end

Quando /^eu verifico os programas disponibilizados nos últimos 10 dias$/ do

end

Então /^eu devo ver o total de '(\d+)' programas disponibilizados$/ do |total|
  found = /\d+$/.match(find(:xpath, "//form[@name='form_programas']/div[@name='div_total_programas']").text).to_s
  total.should eq found
end

Quando /^eu clico no botão 'Detalhar' do programa '(\d+)'$/ do |codigo|
  find(:xpath, "//tr/td[text()='#{codigo}']/../td[4]/a").click
end

Então /^eu devo ver a página de detalhamento do programa '(\d+)'$/ do |codigo|
  find(:xpath, "//div[@name='codigo']").text.should eq "Código: #{codigo}"
  has_text? 'Dados do Programa'
  has_text? 'Datas'
  has_text? 'Órgãos Administrativos Relacionados'
  has_link? 'Voltar'
end
