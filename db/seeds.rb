# encoding: utf-8

def load_data_from_csv(file)
  data = Array.new
  text = File.read(file)  
  csv = CSV.parse(text, :headers => true, :force_quotes => true, :col_sep => ',')
  columns = csv.headers
  
  csv.each do |row|
    row_data = Hash.new
    columns.each do |column|
      row_data[column] = row[column]
    end
    
    data << row_data
  end
  
  data
end

def get_tags_without_stopwords(text)
  return [] if text.nil? || text.empty?
  
  tags = text.split(/[\s\/]/)
  tags.each {|tag| tag.downcase! }
  tags.delete_if {|t| STOPWORDS.include? t }
end

shell.say 'Populando base de dados do projeto'
shell.say ''

shell.say "Carregando dados de 'concedentes' do arquivo 'concedentes_db.csv'"
data = load_data_from_csv 'db/concedentes_db.csv'

concedentes = {}
data.each {|row| concedentes[row['id']] = row['nome'] }

shell.say ''
shell.say "Removendo (se existir) registros da coleção 'programas'"
Programa.destroy
shell.say ''

shell.say "Carregando dados de 'programas' do arquivo 'programas_db.csv'"
data = load_data_from_csv 'db/programas_db.csv'

data.each do |row|
  data_disponibilizacao = nil
  if row['data_disponibilizacao']
    tokens = row['data_disponibilizacao'].split '-'    
    data_disponibilizacao = Time.new(tokens[0], tokens[1], tokens[2])
  end
  
  tagged_orgs = []
  org_exe = concedentes[row['orgao_executor']]
  tags = get_tags_without_stopwords(org_exe)
  tagged_orgs << org_exe
  
  org_sup = concedentes[row['orgao_superior']]
  tags.concat get_tags_without_stopwords(org_sup) unless tagged_orgs.include? org_sup
  tagged_orgs << org_sup
  
  org_mand = concedentes[row['orgao_mandatario']]
  tags.concat get_tags_without_stopwords(org_mand) unless tagged_orgs.include? org_mand
  tagged_orgs << org_mand
  
  org_vin = concedentes[row['orgao_vinculado']]
  tags.concat get_tags_without_stopwords(org_vin) unless tagged_orgs.include? org_vin
  tagged_orgs << org_vin
  
  Programa.create(:cod_programa_siconv => row['cod_programa_siconv'],
                  :data_disponibilizacao => data_disponibilizacao, :data_fim_recebimento_propostas => row['data_fim_recebimento_propostas'],
                  :data_inicio_recebimento_propostas => row['data_inicio_recebimento_propostas'], :data_publicacao_dou => row['data_publicacao_dou'],
                  :nome => row['nome'], :obriga_plano_trabalho => row['obriga_plano_trabalho'],
                  :orgao_executor => org_exe, :orgao_mandatario => org_mand,
                  :orgao_superior => org_sup, :orgao_vinculado => org_vin,
                  :tags => tags)
end

shell.say ''
shell.say 'Povoamento da base de dados concluído'

if PADRINO_ENV == 'production'
  shell.say ''
  shell.say 'Publicando programas disponibilizados recentemente no Twitter'

  # https://github.com/sferik/twitter
  Twitter.configure do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
    config.oauth_token = ENV['OAUTH_TOKEN']
    config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
  end

  Twitter.update "Extração de dados de Programas do Governo Federal realizada em #{LAST_EXTRACTION_DATE}."
  last_days = 10

  programas = Programa.most_up_to_date_programs :last_days => last_days
  (programas.size - 1).downto(0) do |i|
    tweet = "<a href=\"http://novosprogramas.herokuapp.com/programa/#{programas[i].cod_programa_siconv}\">#{programas[i].nome}</a>"
    Twitter.update tweet
  end

  Twitter.update "Divulgando Programas do Governo Federal disponibilizados nos últimos #{last_days}."

  shell.say ''
  shell.say 'Publicação de programas no Twitter concluída'
end
