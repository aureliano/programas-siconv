# encoding: utf-8

require 'spec_helper'

describe "Entidade ProgramaPeriodoStat" do

  let(:programa) { ProgramaPeriodoStat.new }
  
  it 'pode ser criada' do
    programa.should_not be_nil    
  end
  
  it 'permite acesso a todos os atributos' do
    programa.should respond_to :_id
    programa.should respond_to :ano
    programa.should respond_to :mes
    programa.should respond_to :total
  end
  
end
