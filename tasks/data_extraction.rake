# encoding: utf-8
#
# Tarefa para automação do processo de rastreamento e extração de dados.
#
# autor: Aureliano
# data: 07/11/2012

namespace :data do
  resources = {
    :concedentes => 'http://api.convenios.gov.br/siconv/v1/consulta/orgaos.<formato>',
    :programas   => 'http://api.convenios.gov.br/siconv/v1/consulta/programas.<formato>?situacao=DISPONIBILIZADO'
  }

  desc 'Web crawler para extração dos dados da api de dados do Siconv'
  task :extraction do
    `mkdir tmp` unless File.exist? 'tmp'
    resources.each do |k, v|
      puts "Carregando arquivos de dados de '#{k}'"
      download_data_files(v.sub(/<formato>/ , 'csv'), 'csv')
    end
  end

  def download_data_files(base_url, data_type)
    page_size = 500
    
    object_path = base_url[base_url.rindex('/') + 1, base_url.size]
    object_path = 'tmp/' + object_path[0, object_path.index('.')]
    
    page_index = 0
    while true do
      url = base_url.clone
      offset = page_index * page_size
      
      if offset > 0
        url << ((url.include? '?') ? '&' : '?')
        url << "offset=#{offset}"
      end
      
      while true do
        `wget -O #{object_path}_db_#{offset}.#{data_type} "#{url}"`
        break if $?.to_i == 0
        sleep 1
      end
      
      break if `du #{object_path}_db_#{offset}.#{data_type}`.split("\t")[0].to_i == 4
      page_index += 1
    end
    
  end
  
end
