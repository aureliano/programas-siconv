require 'date'

class Programa
  include DataMapper::Resource
  
  property :aceita_emenda_parlamentar, Boolean
  property :cod_programa_siconv, String
  property :data_disponibilizacao, Time
  property :data_fim_emenda_parlamentar, String
  property :data_fim_recebimento_propostas, String
  property :data_inicio_emenda_parlamentar, String
  property :data_inicio_recebimento_propostas, String
  property :data_publicacao_dou, String
  property :nome, String
  property :obriga_plano_trabalho, Boolean
  
  property :orgao_superior, String
  property :orgao_executor, String
  property :orgao_mandatario, String
  property :orgao_vinculado, String
  
  def self.most_up_to_date_programs(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    end_time = Time.new(tokens[2], tokens[1], tokens[0])
    start_time = end_time - (options[:last_days] * DAY)

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
=begin  
  private
    def self.get_entities(search_options)
      entity = search_options[:collection_name].capitalize.sub(/s$/, '')
      entities = Array.new    
      find_documents(search_options) {|values| entities << eval(entity).new(values) }
      entities
    end
    
    def self.count_entities(options)
      collection = Mongo::Connection.new.db(repository('default').adapter.options[:database])[options[:collection_name]]
      collection.find(options[:filter_name] => options[:filter_value]).count()
    end
  
    def self.find_documents(options, &block)
      collection = Mongo::Connection.new.db(repository('default').adapter.options[:database])[options[:collection_name]]
      page = (options[:page].nil?) ? 0 : options[:page]
      limit = (options[:limit].nil?) ? 0 : options[:limit]
      
      collection.find(options[:filter_name] => options[:filter_value]).sort(options[:order_by]).skip(page).limit(limit).each do |document|
        hash = Hash.new
        document.each_pair {|k, v| hash[k] = v unless k == '_id'}
        block.call hash
      end
    end
=end
end
