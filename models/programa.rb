class Programa < ActiveRecord::Base
  belongs_to :orgao_executor,   :class_name => 'Concedente'
  belongs_to :orgao_mandatario, :class_name => 'Concedente'
  belongs_to :orgao_superior,   :class_name => 'Concedente'
  belongs_to :orgao_vinculado,  :class_name => 'Concedente'
  
  def self.most_up_to_date_programs(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    puts options[:last_days]
    time = Time.new(tokens[2], tokens[1], tokens[0]) - options[:last_days].days
    
    Programa.order('data_disponibilizacao DESC').where('data_disponibilizacao >= ?', time).offset(options[:page]).limit(options[:limit])
  end
  
  def self.most_up_to_date_programs_count(options)
    tokens = LAST_EXTRACTION_DATE.split '/'
    time = Time.new(tokens[2], tokens[1], tokens[0]) - options[:last_days].days
    
    Programa.where('data_disponibilizacao >= ?', time).size
  end
end
