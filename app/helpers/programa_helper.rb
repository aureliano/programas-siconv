ProgramasSiconv.helpers do

  def most_up_to_date_programs(limit)
    tokens = LAST_EXTRACTION_DATE.split '/'
    time = Time.new(tokens[2], tokens[1], tokens[0]) - 10.days
    
    Programa.order('data_disponibilizacao DESC').where('data_disponibilizacao >= ?', time).limit(limit)
  end  
end
