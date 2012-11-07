# encoding: utf-8
#
# Tarefa para automação do processo de tratamento de arquivos CSV. Mescla os dados
# de todos os arquivos CSV para uma entidade e gera um novo arquivo de dados no formato CSV.
#
# autor: Aureliano
# data: 07/11/2012

require 'csv'

namespace :data do
  resources = {
    :programas => { :file => 'tmp/programas_db_<offset>.csv', :columns => ['id', 'cod_programa_siconv', 'data_disponibilizacao', 'data_fim_recebimento_propostas', 'data_inicio_recebimento_propostas', 'data_publicacao_dou', 'nome', 'obriga_plano_trabalho', 'orgao_executor', 'orgao_mandatario', 'orgao_superior', 'orgao_vinculado'] },
  }

  desc 'Mescla todos osarquivos de dados (CSV) de uma entidade (após a execução os arquivos da pasta tmp são excluídos)'
  task :merge do
    resources.each do |k, v|
      puts "Carregando arquivos de dados de '#{k}'"
      data = []
      get_data_files(v[:file]).each {|file| data.concat(load_data_from_csv(file, v[:columns])) }

      write_file k.to_s, v[:columns], data
    end
    
    puts `rm tmp/*`
    File.open('.data_extraction_date', 'w') {|file| file.write Time.now.strftime('%d/%m/%Y') }
  end

  def write_file(entity, columns, data)
    file = 'db/' + entity + '_db.csv'
    puts "Escrevendo arquivo de dados #{file}"

    text = columns.join(',') + "\n"
    data.each {|line| text << line.join(',') + "\n" }
    
    File.open(file, 'w') {|f| f.write text }
  end

  def load_data_from_csv(file, columns)
    data = []
    text = File.read(file)
    csv = CSV.parse(text, :headers => true, :col_sep => ',')
    csv.each do |row|
      row_data = []
      columns.each do |column|
        row_data << ((row[column].nil?) ? nil : "\"#{get_column_value(row[column]).gsub(/"/, '""')}\"")
      end

      data << row_data
    end

    data
  end

  def get_column_value(value)
    match = value.match(/^<objeto:\shttp:\/\/[\w\.\/-]*>$/)
    if match
      new_value = match.to_s[/\/-?\d+>/]
      return new_value[1, new_value.size - 2]
    else
      return value
    end
  end

  def get_data_files(seed)
    frequency = 500
    files = []
    page_index = 0
    
    while true do
      file = seed.sub /<offset>/, (page_index * frequency).to_s
      break unless File.exist? file
      files << file
      page_index += 1
    end

    files
  end
end
