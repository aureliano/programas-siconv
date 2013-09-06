# encoding: utf-8

require 'spec_helper'

describe "Entidade Programa" do

  let(:programa) { Programa.new }
  it 'pode ser criada' do
    programa.should_not be_nil
  end
  
  it 'permite acesso a todos os atributos' do
    programa.should respond_to :aceita_emenda_parlamentar
    programa.should respond_to :_id
    programa.should respond_to :codigo_programa
    programa.should respond_to :data_disponibilizacao
    programa.should respond_to :data_fim_recebimento_propostas
    programa.should respond_to :data_inicio_recebimento_propostas
    programa.should respond_to :data_fim_emenda_parlamentar
    programa.should respond_to :data_inicio_emenda_parlamentar
    programa.should respond_to :data_fim_beneficiario_especifico
    programa.should respond_to :data_inicio_beneficiario_especifico
    programa.should respond_to :nome
    programa.should respond_to :obriga_plano_trabalho
    programa.should respond_to :orgao_superior
    programa.should respond_to :orgao_executor
    programa.should respond_to :orgao_mandatario
    programa.should respond_to :orgao_vinculado
    programa.should respond_to :data_expiracao_programa
    programa.should respond_to :esferas_administrativas
    programa.should respond_to :ufs_habilitadas
  end
  
  it 'carrega os programas disponibilizados nos últimos 10 dias' do
    populate_programs_collection
    programas = Programa.most_up_to_date_programs :last_days => 10
    programas.size.should eq 2
  end
  
  it 'conta o número de programas disponibilizados nos últimos 10 dias' do
    populate_programs_collection
    size = Programa.count_most_up_to_date_programs 10
    size.should eq 2
  end
end
