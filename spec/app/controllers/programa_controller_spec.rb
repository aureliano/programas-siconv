# encoding: utf-8

require 'spec_helper'

describe "ProgramaController" do

  puts 'Carregando programas no banco de testes'
  populate_programs_collection
  
  it 'carrega página com os programas disponibilizados nos últimos 10 dias' do
    get '/disponibilizacoes'
    
    last_response.body.should include '<title>Novos Programas: Programas Disponibilizados</title>'
    last_response.body.should include '<div name="div_total_programas">Total de programas: 2</div>'
  end
  
  it 'carrega página de detalhamento do programa' do
    get '/programa/12345678945'
    
    last_response.body.should include '<title>Novos Programas: Dados Programa</title>'
    last_response.body.should include '<span><strong>Código: </strong></span><span>12345678945</span>'
    last_response.body.should include '<h4>Dados do Programa</h4>'
    last_response.body.should include '<h4>Datas</h4'
    last_response.body.should include '<h4>Órgãos Administrativos Relacionados</h4>'
  end
  
  it 'carrega página de consulta de programas' do
    get '/consulta/programas'
    
    last_response.body.should include '<title>Novos Programas: Consulta Programas</title>'
    last_response.body.should include '<form method="get" id="form_consulta" action="/consulta/programas" protect_from_csrf="true" accept-charset="UTF-8">  <div class="input-append">'
  end
  
  it 'carrega página inicial de estatística' do
    get '/estatisticas'
    
    last_response.body.should include '<title>Novos Programas: Estatísticas</title>'
    last_response.body.should include '<h3>Indicadores de Programas</h3>'
  end
  
  it 'carrega página de estatística período/ano' do
    get '/estatisticas/periodo/ano'
    
    last_response.body.should include '<title>Novos Programas: Estatísticas</title>'
    last_response.body.should include '<h3>Programas por ano</h3>'
  end
  
  it 'carrega página de estatística período/mes' do
    get '/estatisticas/periodo/mes'
    
    last_response.body.should include '<title>Novos Programas: Estatísticas</title>'
    last_response.body.should include '<h3>Programas por mês</h3>'
  end
  
end
