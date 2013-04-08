# encoding: utf-8

require 'rest_client'

desc 'Remova-me quando não precisar mais de mim.'
task :teste do
  puts 'Carregando órgãos concedentes'
  puts RestClient.get 'http://api.convenios.gov.br/siconv/v1/consulta/orgaos.xml'
  
  puts "\n\nCarregando programas"
  puts RestClient.get 'http://api.convenios.gov.br/siconv/v1/consulta/programas.xml?situacao=DISPONIBILIZADO'
end
