# encoding: utf-8

Dado /^que eu acesso a página inicial do sistema$/ do
  visit '/'
end

Dado /^que eu preencho o campo '(.+)' com '(.+)'$/ do |campo, valor|
  fill_in campo, :with => valor
end

Dado /^que eu seleciono o campo '(.+)' com '(.+)'$/ do |campo, valor|
  select valor, :from => campo
end

Dado /^que eu marco o campo '(.+)'$/ do |campo|
  check campo
end

Quando /^eu clico no botão '(.+)'$/ do |botao|
  click_button botao
end

Quando /^eu clico no link '(.+)'$/ do |link|
  click_link link
end

Então /^eu devo ver o campo '(.+)'$/ do |campo|
  page.find_field(campo).visible?
end

Então /^eu devo ver o link '(.+)'$/ do |link|
  page.find_link(link).visible?
end

Então /^eu devo ver o botão '(.+)'$/ do |botao|
  page.find_button(botao).visible?
end

Então /^eu devo ver a mensagem '(.+)'$/ do |mensagem|
  pending
end
