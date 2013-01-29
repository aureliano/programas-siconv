# encoding: utf-8

require 'yaml'

Quando /^eu clico no link de versão do sítio$/ do
  click_link "Versão #{APP_VERSION}"
end

Então /^eu devo ver a página com as mudanças da versão atual$/ do
  should have_text 'Log de versão'
  should have_text 'Acompanhe aqui as alterações realizadas no sítio.'
  verifica_log_versao_atual
end

Então /^eu devo ver a página com as mudanças de todas as versões$/ do
  should have_text 'Log de versão'
  should have_text 'Acompanhe aqui as alterações realizadas no sítio.'
  verifica_log_completo
end

def verifica_log_versao_atual
  log = YAML.load_file 'changelog.yml'
  log[APP_VERSION].each {|feature| should have_text feature }
  should have_link 'Ver log completo...'
end

def verifica_log_completo
  log = YAML.load_file 'changelog.yml'
  log.each_value do |features|
    features.each {|feature| should have_text feature }
  end
  should_not have_link 'Ver log completo...'
end
