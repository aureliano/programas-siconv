# encoding: utf-8

Dado /^que existem '(\d+)' programas disponibilizados no ano '(\d{4})' e no mês '(\d{1,2})'$/ do |total, ano, mes|
  ProgramaPeriodoStat.create :ano => ano, :mes => mes, :total => total
end

Dado /^que existem '(\d+)' programas disponibilizados pelo concedente '([\w\s]+)' no ano '(\d{4})'$/ do |total, concedente, ano|
  ProgramaOrgaoStat.create :ano => ano, :concedente => concedente, :total => total
end

Dado /^que eu acesso a página de dados estatísticos de programas por período\/ano$/ do
  find(:xpath, "//div/a[@class='btn btn-info']").click
end

Dado /^que eu acesso a página de dados estatísticos de programas por período\/mês$/ do
  find(:xpath, "//div/a[@class='btn btn-primary']").click
end

Dado /^que eu acesso a página de dados estatísticos de programas por órgão superior$/ do
  find(:xpath, "//div/a[@class='btn btn-success']").click
end

Então /^eu devo ver a página de dados estatísticos$/ do
  should have_text "Aqui você encontrará dados estatístico de Programas de Convênio do Governo Federal."
  "Período/Ano".should eq find(:xpath, "//div/a[@class='btn btn-info']/h3").text
  "Período/Mês".should eq find(:xpath, "//div/a[@class='btn btn-primary']/h3").text
  "Órgão Superior".should eq find(:xpath, "//div/a[@class='btn btn-success']/h3").text
end

Então /^eu devo ver a página com os dados estatístico de programas por período\/ano$/ do
  should have_text "Programas de Convênio disponibilizados pelo Governo Federal agregados por ano."
  should have_xpath "//div[@id='chart_div']"
end

Então /^eu devo ver a página com os dados estatístico de programas por período\/mês$/ do
  should have_text "Programas de Convênio disponibilizados pelo Governo Federal agregados por mês."
  should have_xpath "//div[@id='chart_div']"
end

Então /^eu devo ver a página com os dados estatístico de programas por órgão superior$/ do
  should have_text "Programas de Convênio disponibilizados pelo Governo Federal agregados por Órgão Superior."  
end

Então /^eu devo ver o gráfico de programas$/ do
  should have_xpath "//div[@id='chart_div']"
end
