# encoding: utf-8
#
# Tarefa para automação do processo de preparação dos dados.
#
# autor: Aureliano
# data: 07/11/2012

namespace :data do

  desc 'Gera arquivos de dados do sistema para posterior preenchimento da base de dados'
  task :prepare => [:extraction, :merge] do
    puts 'Preparando arquivos de dados do sistema'
  end
end
