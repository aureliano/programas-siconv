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
  
  Programa.create(:id => row['id'], :cod_programa_siconv => row['cod_programa_siconv'],
                  :data_disponibilizacao => data_disponibilizacao, :data_fim_recebimento_propostas => row['data_fim_recebimento_propostas'],
                  :data_inicio_recebimento_propostas => row['data_inicio_recebimento_propostas'], :data_publicacao_dou => row['data_publicacao_dou'],
                  :nome => row['nome'], :obriga_plano_trabalho => row['obriga_plano_trabalho'],
                  :orgao_executor => concedentes[row['orgao_executor']], :orgao_mandatario => concedentes[row['orgao_mandatario']],
                  :orgao_superior => concedentes[row['orgao_superior']], :orgao_vinculado => concedentes[row['orgao_vinculado']])
end

shell.say ''

shell.say 'Povoamento da base de dados concluído'
