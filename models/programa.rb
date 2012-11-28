class Programa
  include DataMapper::Resource
  
  property :id, Integer
  property :acao_orcamentaria, String
  property :aceita_emenda_parlamentar, Boolean
  property :cod_programa_siconv, String
  property :data_disponibilizacao, String
  property :data_fim_beneficiario_especifico, String
  property :data_fim_emenda_parlamentar, String
  property :data_fim_recebimento_propostas, String
  property :data_inicio_beneficiario_especifico, String
  property :data_inicio_emenda_parlamentar, String
  property :data_inicio_recebimento_propostas, String
  property :data_publicacao_dou, String
  property :descricao, String
  property :nome, String
  property :obriga_plano_trabalho, Boolean
  
  property :orgao_superior, String
  property :orgao_executor, String
  property :orgao_mandatario, String
  property :orgao_superior, String
  property :orgao_vinculado, String
  
  #def self.most_up_to_date_programs(options)
  #  tokens = LAST_EXTRACTION_DATE.split '/'
  #  puts options[:last_days]
  #  time = Time.new(tokens[2], tokens[1], tokens[0]) - options[:last_days].days
    
  #  Programa.order('data_disponibilizacao DESC').where('data_disponibilizacao >= ?', time).offset(options[:page]).limit(options[:limit])
  #end
  
  #def self.most_up_to_date_programs_count(options)
  #  tokens = LAST_EXTRACTION_DATE.split '/'
  #  time = Time.new(tokens[2], tokens[1], tokens[0]) - options[:last_days].days
    
  #  Programa.where('data_disponibilizacao >= ?', time).size
  #end
end
