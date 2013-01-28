# encoding: utf-8

Dado /^que eu acesso a página inicial do sistema$/ do
  visit '/'
end

Dado /^que eu preencho o campo '([\w\s]+)' com '([\p{L}\s]+)'$/ do |campo, valor|
  fill_in campo, :with => valor
end

Dado /^que eu seleciono o campo '([\w\s]+)' com '([\p{L}\s]+)'$/ do |campo, valor|
  select valor, :from => campo
end

Dado /^que eu marco o campo '([\w\s]+)'$/ do |campo|
  check campo
end

Quando /^eu clico no botão '([\p{L}\s-]+)'$/ do |botao|
  click_button botao
end

Quando /^eu clico no link '([\.\p{L}\s-]+)'$/ do |link|
  click_link link
end

Quando /^eu clico no item '([\p{L}\s-]+)' do menu$/ do |item|
  find(:xpath, "//div/ul/li/a[text() = '#{item}']").click
end

Então /^eu devo ver o campo '([\w\s]+)'$/ do |campo|
  find_field(campo).visible?
end

Então /^eu devo ver o link '([\p{L}\s-]+)'$/ do |link|
  find_link(link).visible?
end

Então /^eu devo ver o botão '([\p{L}\s-]+)'$/ do |botao|
  find_button(botao).visible?
end

Então /^eu devo ver a mensagem '([\p{L}\s-]+)'$/ do |mensagem|
  pending
end
