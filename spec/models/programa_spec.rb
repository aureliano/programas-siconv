# encoding: utf-8

require 'spec_helper'

describe "Entidade Programa" do

  let(:programa) { Programa.new }
  it 'pode ser criada' do
    programa.should_not be_nil    
  end
  
  it 'permite acesso a todos os atributos' do
    programa.should respond_to :aceita_emenda_parlamentar
    programa.should respond_to :cod_programa_siconv
    programa.should respond_to :data_disponibilizacao
    programa.should respond_to :data_fim_recebimento_propostas
    programa.should respond_to :data_inicio_recebimento_propostas
    programa.should respond_to :data_publicacao_dou
    programa.should respond_to :nome
    programa.should respond_to :obriga_plano_trabalho
    programa.should respond_to :orgao_superior
    programa.should respond_to :orgao_executor
    programa.should respond_to :orgao_mandatario
    programa.should respond_to :orgao_vinculado
    programa.should respond_to :tags
  end
  
  it 'salva novo programa na base de dados' do
    Programa.create :aceita_emenda_parlamentar => true, :cod_programa_siconv => '12345678945',
                    :data_disponibilizacao => Time.now, :data_fim_recebimento_propostas => '2013-09-01',
                    :data_inicio_recebimento_propostas => '2013-01-02', :nome => 'Programa de Teste',
                    :obriga_plano_trabalho => true, :orgao_executor => 'MINISTERIO DOS TESTES', :tags => ['MINISTERIO', 'TESTES']
    Programa.find(:cod_programa_siconv => '12345678945').first.should_not be_nil
  end
  
  it 'remove todos os programas da base de dados' do
    Programa.create :cod_programa_siconv => '12345678945', :data_disponibilizacao => Time.now, :nome => 'Programa de Teste',
                    :obriga_plano_trabalho => true, :orgao_executor => 'MINISTERIO DOS TESTES'
    Programa.destroy
    Programa.find({}).size.should eq 0
  end
  
  it 'carrega os programas disponibilizados nos últimos 10 dias' do
    populate_programs_collection
    programas = Programa.most_up_to_date_programs :last_days => 10
    programas.size.should eq 2
  end
  
  it 'conta o número de programas disponibilizados nos últimos 10 dias' do
    populate_programs_collection
    size = Programa.count_most_up_to_date_programs :last_days => 10
    size.should eq 2
  end
end
