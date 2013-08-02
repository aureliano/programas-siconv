# encoding: utf-8
#
# Tarefa para automação do processo de preparação dos dados.
#
# autor: Aureliano
# data: 07/11/2012

DAY_SEED = 2

namespace :data do

  task :prepare => [:extraction, :merge] do
    
  end
  
  desc 'Carrega dados extraídos da API de dados abertos e salva no banco de dados para tratamento posterior (rake seed)'
  task :fill do
    $data_preparation_start = Time.now
    if (Time.now.day % DAY_SEED) > 0
      puts "Cancelando povoamento de dados. O povoamento de dados só ocorre nos dias do mês que são múltiplos de #{DAY_SEED}."
      Process.exit 0
    end
    
    ['data:extraction', 'data:merge', 'seed'].each do |task_name|
      begin
        Rake::Task[task_name].invoke
      rescue Exception => ex
        puts "Encerrando processo devido a um erro.\nExceção: #{ex}"
        Process.exit -1
      end
    end
  end
end
