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
      totais[nome_mes mes] = soma
    end
    
    data = [['Mês', 'Programas']]
    totais.each {|k, v| data << [k.to_s, v] }
    data
  end
  
  def programas_por_concedente_chart_data(concedente)
    docs = ProgramaOrgaoStat.where(:concedente => concedente)
    return [] if docs.empty?
    totais = {}
    (2008..Time.now.year).each do |ano|
      doc = docs.select {|d| d.ano == ano }.first
      totais[ano] = (doc) ? doc.total : 0
    end
    
    data = [['Ano', 'Programas']]
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
  
  def nome_mes(mes)
    case mes
      when 1 then 'Jan'
      when 2 then 'Fev'
      when 3 then 'Mar'
      when 4 then 'Abr'
      when 5 then 'Mai'
      when 6 then 'Jun'
      when 7 then 'Jul'
      when 8 then 'Ago'
      when 9 then 'Set'
      when 10 then 'Out'
      when 11 then 'Nov'
      when 12 then 'Dez'
    end
  end
end
