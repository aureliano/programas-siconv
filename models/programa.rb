class Programa
  include Mongoid::Document
  
  field :_id, :type => Integer
  field :aceita_emenda_parlamentar, :type => Boolean
  field :data_disponibilizacao, :type => Date
  field :data_fim_beneficiario_especifico, :type => String
  field :data_inicio_beneficiario_especifico, :type => String
  field :data_fim_emenda_parlamentar, :type => String
  field :data_inicio_emenda_parlamentar, :type => String
  field :data_fim_recebimento_propostas, :type => Date
  field :data_inicio_recebimento_propostas, :type => String
  field :nome, :type => String
  field :obriga_plano_trabalho, :type => Boolean
  field :orgao_superior, :type => String
  field :orgao_executor, :type => String
  field :orgao_mandatario, :type => String
  field :orgao_vinculado, :type => String

  def self.most_up_to_date_programs(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    end_time = Time.new(tokens[2], tokens[1], tokens[0]) + DAY
    start_time = end_time - (options[:last_days] * DAY)
    options[:skip] ||= 0
    options[:limit] ||= 0

    programas = []
    
    where(:data_disponibilizacao => {'$gte' => start_time, '$lte' => end_time}).desc(:data_disponibilizacao).skip(options[:skip]).limit(options[:limit]).each {|document| programas << document }    
    programas
  end
  
  def self.count_most_up_to_date_programs(last_days)
    tokens = LAST_EXTRACTION_DATE.split '/'
    end_time = Time.new(tokens[2], tokens[1], tokens[0]) + DAY
    start_time = end_time - (last_days * DAY)

    where(:data_disponibilizacao => {'$gte' => start_time, '$lte' => end_time}).count
  end
  
  def self.search(options)
    [_search(options), _count_search(options)]
  end
  
  def self.orgaos_superiores
    only(:orgao_superior).distinct(:orgao_superior)
  end
  
  private
    def self._search(options)
      options[:skip] ||= 0
      options[:limit] ||= 0
      programas = []
      
      where(:orgao_superior => options[:orgao_superior])
        .desc(:data_disponibilizacao)
        .skip(options[:skip])
        .limit(options[:limit])
        .each {|document| programas << document }
      programas
    end
    
    def self._count_search(options)
      where(:orgao_superior => options[:orgao_superior]).count
    end
end
