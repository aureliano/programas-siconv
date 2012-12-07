class Programa

  def initialize(props = {})
    @aceita_emenda_parlamentar = props['aceita_emenda_parlamentar']
    @cod_programa_siconv = props['cod_programa_siconv']
    @data_disponibilizacao = props['data_disponibilizacao']
    @data_fim_recebimento_propostas = props['data_fim_recebimento_propostas']
    @data_inicio_recebimento_propostas = props['data_inicio_recebimento_propostas']
    @data_publicacao_dou = props['data_publicacao_dou']
    @nome = props['nome']
    @obriga_plano_trabalho = props['obriga_plano_trabalho']
    @orgao_superior = props['orgao_superior']
    @orgao_executor = props['orgao_executor']
    @orgao_mandatario = props['orgao_mandatario']
    @orgao_vinculado = props['orgao_vinculado']
    @tags = props['tags']
  end
  
  attr_accessor :aceita_emenda_parlamentar, :cod_programa_siconv, :data_disponibilizacao,
                :data_fim_recebimento_propostas, :data_inicio_recebimento_propostas,
                :data_publicacao_dou, :nome, :obriga_plano_trabalho, :orgao_superior,
                :orgao_executor, :orgao_mandatario, :orgao_vinculado, :tags

  def self.find(filters)
    collection = DATABASE['programas']
    programas = Array.new
    
    collection.find(filters).sort([:data_disponibilizacao, -1]).each do |document|
      hash = Hash.new
      document.each_pair {|k, v| hash[k] = v unless k == '_id'}
      programas << Programa.new(hash)
    end
    
    programas
  end

  def self.most_up_to_date_programs(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    end_time = Time.new(tokens[2], tokens[1], tokens[0]) + DAY
    start_time = end_time - (options[:last_days] * DAY)
    options[:page] = 0 if options[:page].nil?
    options[:limit] = 0 if options[:limit].nil?

    collection = DATABASE['programas']
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
    end_time = Time.new(tokens[2], tokens[1], tokens[0]) + DAY
    start_time = end_time - (options[:last_days] * DAY)
    
    collection = DATABASE['programas']
    collection.find({:data_disponibilizacao => {'$gte' => start_time, '$lte' => end_time}}).count
  end
  
  def self.with_tags(options)
    collection = DATABASE['programas']
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
    collection = DATABASE['programas']
    collection.find(:tags => {'$all' => options[:tags]}).count(true)
  end
  
  def self.create(programa)
    DATABASE['programas'].save programa
  end
  
  def self.destroy
    DATABASE['programas'].remove
  end
end
