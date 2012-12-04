# encoding: utf-8

require 'spec_helper'

describe "ProgramaController" do

  puts 'Carregando programas no banco de testes'
  populate_programs_collection

  it 'carrega página inicial com os programas disponibilizados nos últimos 10 dias' do
    get '/'
    
    last_response.body.should include '<title>Novos Programas: Início</title>'
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
  
  it 'redireciona usuário para página de erro 404' do
    get '/pagina_inexistente'
    
    last_response.body.should eq '<h2>Página inexistente.</h2>'
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
    last_response.body.should include '<form method="get" id="form_consulta" class="form-search" action="/consulta/programas" accept-charset="UTF-8">  <div class="input-append">'
  end
  
end
