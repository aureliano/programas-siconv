PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  ProgramasSiconv.tap { |app|  }
end

def populate_programs_collection
  Programa.delete_all
  
  Programa.create :aceita_emenda_parlamentar => true, :_id => 12345678945, :codigo_programa => 12345678945,
                  :data_disponibilizacao => Time.now, :data_fim_recebimento_propostas => '2013-09-01',
                  :data_inicio_recebimento_propostas => '2013-01-02', :nome => 'Programa de Teste 1 ',
                  :obriga_plano_trabalho => true, :orgao_superior => 'MINISTERIO DOS TESTES'
  Programa.create :aceita_emenda_parlamentar => true, :_id => 565689765465, :codigo_programa => 565689765465,
                  :data_disponibilizacao => Time.now - (10 * DAY), :data_fim_recebimento_propostas => '2013-09-01',
                  :data_inicio_recebimento_propostas => '2013-01-02', :nome => 'Programa de Teste 2 ',
                  :obriga_plano_trabalho => true, :orgao_superior => 'MINISTERIO DAS ESPECIFICACOES'
  Programa.create :aceita_emenda_parlamentar => true, :_id => 798432120, :codigo_programa => 798432120,
                  :data_disponibilizacao => Time.now - (11 * DAY), :data_fim_recebimento_propostas => '2013-09-01',
                  :data_inicio_recebimento_propostas => '2013-01-02', :nome => 'Programa de Teste 3 ',
                  :obriga_plano_trabalho => true, :orgao_superior => 'MINISTERIO NUMERO UM'
  Programa.create :aceita_emenda_parlamentar => true, :_id => 6648785121321, :codigo_programa => 6648785121321,
                  :data_disponibilizacao => Time.now - (5 * DAY), :data_fim_recebimento_propostas => '2013-09-01',
                  :data_inicio_recebimento_propostas => '2013-01-02', :nome => 'Programa de Teste 4 ',
                  :obriga_plano_trabalho => true, :orgao_superior => 'MINISTERIO NUMERO UM'
end
