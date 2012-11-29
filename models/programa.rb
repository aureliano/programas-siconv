require 'date'

class Programa
  include DataMapper::Resource
  
  property :aceita_emenda_parlamentar, Boolean
  property :cod_programa_siconv, String
  property :data_disponibilizacao, Time
  property :data_fim_recebimento_propostas, String
  property :data_inicio_recebimento_propostas, String
  property :data_publicacao_dou, String
  property :nome, String
  property :obriga_plano_trabalho, Boolean
  
  property :orgao_superior, String
  property :orgao_executor, String
  property :orgao_mandatario, String
  property :orgao_vinculado, String
  
  property :tags, Array
  
  def self.most_up_to_date_programs(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    end_time = Time.new(tokens[2], tokens[1], tokens[0])
    start_time = end_time - (options[:last_days] * DAY)
    options[:page] = 0 if options[:page].nil?
    options[:limit] = 0 if options[:limit].nil?

    collection = Mongo::Connection.new.db(repository('default').adapter.options[:database])['programas']
    programas = Array.new
    collection.find({:data_disponibilizacao => {'$gte' => start_time, '$lte' => end_time}}).sort([:data_disponibilizacao, -1]).skip(options[:page]).limit(options[:limit]).each do |document|
      hash = Hash.new
      document.each_pair {|k, v| hash[k] = v unless k == '_id'}
      programas << Programa.new(hash)
    end
    
    programas
  end
  
  def self.count_most_up_to_date_programs(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    end_time = Time.new(tokens[2], tokens[1], tokens[0])
    start_time = end_time - (options[:last_days] * DAY)
    
    collection = Mongo::Connection.new.db(repository('default').adapter.options[:database])['programas']
    collection.find({:data_disponibilizacao => {'$gte' => start_time, '$lte' => end_time}}).count()
  end
  
  def self.with_tags(options)
    collection = Mongo::Connection.new.db(repository('default').adapter.options[:database])['programas']
    programas = Array.new
    options[:page] = 0 if options[:page].nil?
    options[:limit] = 0 if options[:limit].nil?
    
    collection.find(:tags => {'$all' => options[:tags]}).sort([:data_disponibilizacao, -1]).skip(options[:page]).limit(options[:limit]).each do |document|
      hash = Hash.new
      document.each_pair {|k, v| hash[k] = v unless k == '_id'}
      programas << Programa.new(hash)
    end
    
    programas
  end
  
  def self.count_with_tags(options)
    collection = Mongo::Connection.new.db(repository('default').adapter.options[:database])['programas']
    collection.find(:tags => {'$all' => options[:tags]}).count(true)
  end
end
