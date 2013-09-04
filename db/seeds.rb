# encoding: utf-8

start_time = $data_preparation_start.nil? ? Time.now : $data_preparation_start
BUCKET_SIZE = 100

def elapsed_time(t1, t2)
  diff = (t2 - t1)
  s = (diff % 60).to_i
  m = (diff / 60).to_i
  h = (m / 60).to_i

  if s > 0
    "#{(h < 10) ? '0' + h.to_s : h}:#{(m < 10) ? '0' + m.to_s : m}:#{(s < 10) ? '0' + s.to_s : s}"
  else
    format("%.5f", diff) + " milisegundos."
  end
end

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

def time_to_date_s(time)
  return '-' if time.nil?
  time.strftime '%d/%m/%Y'
end

shell.say 'Populando base de dados do projeto'
shell.say ''

shell.say "Carregando dados de 'concedentes' do arquivo 'tmp/concedentes_db.csv'"
data = load_data_from_csv 'tmp/concedentes_db.csv'

concedentes = {}
data.each {|row| concedentes[row['id']] = row['nome'] }

shell.say ''
shell.say "Removendo (se existir) registros da coleção 'programas'"
Programa.delete_all
shell.say ''

shell.say "Carregando dados de 'programas' do arquivo 'tmp/programas_db.csv'"
data = load_data_from_csv 'tmp/programas_db.csv'
docs = 0
programas = []

data.each do |row|
  data_disponibilizacao = nil
  if row['data_disponibilizacao']
    tokens = row['data_disponibilizacao'].split '-'    
    data_disponibilizacao = Time.new(tokens[0], tokens[1], tokens[2])
  end
  
  programas << { :_id => row['id'].to_i, :codigo_programa => row['cod_programa_siconv'].to_i,
                  :data_disponibilizacao => data_disponibilizacao, :data_fim_recebimento_propostas => row['data_fim_recebimento_propostas'],
                  :data_inicio_recebimento_propostas => row['data_inicio_recebimento_propostas'], :data_fim_beneficiario_especifico => row['data_fim_beneficiario_especifico'],
                  :data_inicio_beneficiario_especifico => row['data_inicio_beneficiario_especifico'], :data_fim_emenda_parlamentar => row['data_fim_emenda_parlamentar'],
                  :data_inicio_emenda_parlamentar => row['data_inicio_emenda_parlamentar'],
                  :nome => row['nome'], :obriga_plano_trabalho => row['obriga_plano_trabalho'],
                  :orgao_executor => concedentes[row['orgao_executor']], :orgao_mandatario => concedentes[row['orgao_mandatario']],
                  :orgao_superior => concedentes[row['orgao_superior']], :orgao_vinculado => concedentes[row['orgao_vinculado']] }

  docs += 1
  if docs == BUCKET_SIZE
    Programa.collection.insert programas
    programas.clear
    docs = 0
  end
end

Programa.collection.insert programas # insere o resto
programas.clear

shell.say ''

shell.say 'Criando dados agregados de Programas por período'
load('db/programas_periodo_stat.rb')

shell.say ''

shell.say 'Criando dados agregados de Programas por Concedente'
load('db/programas_orgao_stat.rb')

shell.say ''

shell.say 'Povoamento da base de dados concluído'

metadata = YAML.load_file 'metadata.yml'
metadata['LAST_EXTRACTION_DATE'] = Time.now.strftime('%d/%m/%Y')
File.open('metadata.yml', 'w') {|file| file.write metadata.to_yaml }

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

  last_days = 10

  fb_post = "Divulgando Programas do Governo Federal disponibilizados nos últimos #{last_days} dias.\n"
  fb_post << "Extração de dados de Programas do Governo Federal realizada em #{LAST_EXTRACTION_DATE}.\n"
  programas = Programa.most_up_to_date_programs :last_days => last_days
  
  (programas.size - 1).downto(0) do |i|
    nome = (programas[i].nome.size > 70) ? "#{programas[i].nome[0, 67]}..." : programas[i].nome
    
    fb_post << "\nPrograma: #{programas[i].nome}\n"
    fb_post << "Órgão Executor: #{programas[i].orgao_executor}\n"
    fb_post << "Data de disponibilização: #{time_to_date_s programas[i].data_disponibilizacao}\n"
  end

  Twitter.update "Extração de dados de Programas do Governo Federal realizada em #{LAST_EXTRACTION_DATE}. http://novosprogramas.herokuapp.com/disponibilizacoes"

  shell.say ''
  shell.say 'Publicação de programas no Twitter concluída'
  
  shell.say ''
  shell.say 'Publicando programas disponibilizados recentemente no Facebook'
  
  # https://github.com/arsduo/koala
  Koala.http_service.http_options = {
    :ssl => { :ca_path => "/etc/ssl/certs" }
  }
  graph = Koala::Facebook::API.new(ENV['FACEBOOK_ACCESS_TOKEN'])
  graph.put_connections('147823665372978', 'feed', :message => fb_post)
  
  shell.say
  shell.say 'Publicação de programas no Facebook concluída'
end

shell.say 'Tempo gasto: ' + elapsed_time(start_time, Time.now)
