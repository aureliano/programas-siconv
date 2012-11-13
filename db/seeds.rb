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

shell.say "Removendo (se existir) registros da tabela 'concedentes'"
Concedente.delete_all
shell.say ''

shell.say "Carregando dados de 'concedentes' do arquivo 'concedentes_db.csv'"
data = load_data_from_csv 'db/concedentes_db.csv'

orgaos_superiores = Array.new
orgaos = Array.new

data.each do |row|
  if row['id'] == row['orgao_superior']
    orgaos_superiores << Concedente.new(:orgao_id => row['id'], :nome => row['nome'])
  else
    orgaos << Concedente.new(:orgao_id => row['id'], :nome => row['nome'], :orgao_superior => Concedente.new(:orgao_id => row['orgao_superior']))
  end
end

orgaos_superiores.each {|orgao| orgao.save }
orgaos.each do |orgao|
  orgao.orgao_superior = Concedente.find_by_orgao_superior(orgao.orgao_superior)
  orgao.save
end

shell.say ''
shell.say "Removendo (se existir) registros da tabela 'programas'"
Programa.delete_all
shell.say ''

shell.say "Carregando dados de 'programas' do arquivo 'programas_db.csv'"
data = load_data_from_csv 'db/programas_db.csv'

data.each do |row|
  Programa.create(:programa_id => row['id'], :cod_programa_siconv => row['cod_programa_siconv'],
                  :data_disponibilizacao => row['data_disponibilizacao'], :data_fim_recebimento_propostas => row['data_fim_recebimento_propostas'],
                  :data_inicio_recebimento_propostas => row['data_inicio_recebimento_propostas'], :data_publicacao_dou => row['data_publicacao_dou'],
                  :nome => row['nome'], :obriga_plano_trabalho => row['obriga_plano_trabalho'],
                  :orgao_executor => Concedente.where(:orgao_id => row['orgao_executor'].to_i).first, :orgao_mandatario => Concedente.where(:orgao_id => row['orgao_mandatario'].to_i).first,
                  :orgao_superior => Concedente.where(:orgao_id => row['orgao_superior'].to_i).first, :orgao_vinculado => Concedente.where(:orgao_id => row['orgao_vinculado'].to_i).first)
end
