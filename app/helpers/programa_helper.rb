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
    tokens = date_str.split '-'
    "#{tokens[2]}/#{tokens[1]}/#{tokens[0]}"
  end
  
  def parse_boolean(bool)
    case bool
      when true; then 'Sim'
      when false; then 'Não'
      when 'True'; then 'Sim'
      when 'False'; then 'Não'
      when nil; then 'Não'
    end
  end
  
  def format_get_params(params)
    params.sub /\s/, '+'
  end
  
  def programa_back_link
    filter = params[:search_params]
    page = (params[:page]) ? params[:page] : 1
    
    link = (filter) ? "/consulta/programas?page=#{page}&search_params=#{format_get_params filter}" : url(:index)
  end
  
  def pagination_page_index
    value = params[:page] ||= 1
    page = value.to_i
    page = 1 if page < 1
    
    page
  end
  
  def skip_value(limit=nil)
    limit ||= DataPage.default_page_size
    ((pagination_page_index - 1) * limit)
  end
end
