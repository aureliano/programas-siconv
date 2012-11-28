# encoding: utf-8

ProgramasSiconv.helpers do

  def time_to_date_s(time)
    return '-' if time.nil?
    time.strftime '%d/%m/%Y'
  end
  
  def format_date(date_str)
    return '-' if date_str.nil? || date_str.empty?
    date_str.gsub /-/, '/'
  end
  
  def parse_boolean(bool)
    case bool
      when true; then 'Sim'
      when false; then 'Não'
      when nil; then 'Não'
    end
  end
end
