# encoding: utf-8
#
# Tarefa para automação do processo de rastreamento e extração de dados.
#
# autor: Aureliano
# data: 07/11/2012

require 'rest_client'

namespace :data do

  resources = {
    :concedentes => 'http://api.convenios.gov.br/siconv/v1/consulta/orgaos.<formato>',
    :programas   => 'http://api.convenios.gov.br/siconv/v1/consulta/programas.<formato>?situacao=DISPONIBILIZADO'
  }
  
  desc 'Web crawler para extração dos dados da api de dados do Siconv'
  task :extraction do
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
      
      res = download_data_file(url, object_path, offset, data_type)
      if res != 0
        raise "Encerrando download de arquivos porque o serviço parece estar indisponível no momento."
      end
      
      break if `du #{object_path}_db_#{offset}_tmp.#{data_type}`.split("\t")[0].to_i == 4
      page_index += 1
    end
    
  end
  
  def download_data_file(url, object_path, offset, data_type)
    count = 0
    
    while true do
      return -1 if count > 5
      
      begin
        puts "Baixando recurso #{url}"
        response = RestClient.get url
        File.open("#{object_path}_db_#{offset}_tmp.#{data_type}", 'w') {|f| f.write response}
        break
      rescue
        sleep 3
        count += 1
        puts "Nova tentativa..."
      end
    end
    
    0
  end
  
end
