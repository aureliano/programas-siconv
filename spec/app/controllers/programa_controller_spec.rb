# encoding: utf-8

require 'spec_helper'

describe "ProgramaController" do

  puts 'Carregando programas no banco de testes'
  populate_programs_collection

  it 'carrega página inicial' do
    get '/'
    
    last_response.body.should include '<title>Novos Programas: Início</title>'
    last_response.body.should include '<div class="pagination-centered">'
    last_response.body.should include '<h2>Novos Programas</h2>'
    last_response.body.should include '<h3>Portal para livre consulta de Programas de Convênio.</h3>'
  end
  
  it 'carrega página com os programas disponibilizados nos últimos 10 dias' do
    get '/disponibilizacoes'
    
    last_response.body.should include '<title>Novos Programas: Programas Disponibilizados</title>'
    last_response.body.should include '<div name="div_total_programas">Total de programas: 2</div>'
  end
  
  it 'carrega página com informações sobre o portal' do
    get '/sobre'
    
    last_response.body.should include '<title>Novos Programas: Sobre o sítio</title>'
    last_response.body.should include '<h4>Missão</h4>'
    last_response.body.should include '<h4>Siconv</h4>'
  end
  
  it 'carrega página de inscrição no Feed' do
    get '/feed'
    
    last_response.body.should include '<?xml version="1.0" encoding="UTF-8"?>'
    last_response.body.should include '<rss version="2.0" xmlns:dc="http://purl.org/dc/elements/1.1/">'
    last_response.body.should include '<title>Programa de Teste 1 </title>'
    last_response.body.should include '<title>Programa de Teste 4 </title>'
  end
  
  it 'carrega página com o log da versão atual' do
    get '/log/versao/atual'
    
    last_response.body.should include '<title>Novos Programas: Log de versão</title>'
    last_response.body.should include '<a href="/log/versao/todas">Ver log completo...</a>'
  end
  
  it 'carrega página com o log de todas as versões' do
    get '/log/versao/todas'
    
    last_response.body.should include '<title>Novos Programas: Log de versão</title>'
    last_response.body.should_not include '<a href="/log/versao/todas">Ver log completo...</a>'
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
    last_response.body.should include '<form method="get" id="form_consulta" action="/consulta/programas" accept-charset="UTF-8">  <div class="input-append">'
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
