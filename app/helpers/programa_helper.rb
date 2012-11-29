# encoding: utf-8

ProgramasSiconv.helpers do

  def get_tags_without_stopwords(text)
    return [] if text.nil?
    tags = text.split(/\s/)
    tags.each {|tag| tag.downcase! }
    tags.delete_if {|t| STOPWORDS.include? t }
  end
  
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
