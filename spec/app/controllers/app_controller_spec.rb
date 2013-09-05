# encoding: utf-8

require 'spec_helper'

describe "AppController" do

  it 'carrega página inicial' do
    get '/'
    
    last_response.body.should include '<title>Novos Programas: Início</title>'
    last_response.body.should include '<div class="pagination-centered">'
    last_response.body.should include '<h2>Novos Programas</h2>'
    last_response.body.should include '<h3>Portal para livre consulta de Programas de Convênio.</h3>'
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

end
