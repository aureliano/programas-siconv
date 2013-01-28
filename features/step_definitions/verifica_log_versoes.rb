# encoding: utf-8

Quando /^eu clico no link de versão do sítio$/ do
  click_link "Versão #{APP_VERSION}"
end

Então /^eu devo ver a página com as mudanças da versão atual$/ do
  should have_text 'Log de versão'
  should have_text 'Acompanhe aqui as alterações realizadas no sítio.'
  should have_link 'Ver log completo...'
end

Então /^eu devo ver a página com as mudanças de todas as versões$/ do
  should have_text 'Log de versão'
  should have_text 'Acompanhe aqui as alterações realizadas no sítio.'
  should_not have_link 'Ver log completo...'
end
