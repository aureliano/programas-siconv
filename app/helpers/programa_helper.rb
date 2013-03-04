# encoding: utf-8

ProgramasSiconv.helpers do

  def programas_por_ano_chart_data
    totais = {}
    (2008..Time.now.year).each do |ano|
      soma = 0
      ProgramaPeriodoStat.where(:ano => ano).each {|doc| soma += doc.total }
      totais[ano] = soma
    end
     
    data = [['Ano', 'Programas']]
    totais.each {|k, v| data << [k.to_s, v] }
    data
  end
  
  def programas_por_mes_chart_data(ano=2008)
    ano = 2008 if ano < 2008 || ano > Time.now.year
    totais = {}
    
    (1..12).each do |mes|
      soma = 0
      ProgramaPeriodoStat.where(:ano => ano, :mes => mes).each {|doc| soma += doc.total }
      totais[mes] = soma
    end
    
    data = [['Mês', 'Programas']]
    totais.each {|k, v| data << [k.to_s, v] }
    data
  end

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
