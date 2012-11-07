# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "concedentes", :force => true do |t|
    t.integer "id_orgao"
    t.string  "nome"
  end

  create_table "programas", :force => true do |t|
    t.integer "id_programa"
    t.string  "acao_orcamentaria"
    t.boolean "aceita_emenda_parlamentar"
    t.string  "cod_programa_siconv"
    t.date    "data_disponibilizacao"
    t.date    "data_fim_beneficiario_especifico"
    t.date    "data_fim_emenda_parlamentar"
    t.date    "data_fim_recebimento_propostas"
    t.date    "data_inicio_beneficiario_especifico"
    t.date    "data_inicio_emenda_parlamentar"
    t.date    "data_inicio_recebimento_propostas"
    t.date    "data_publicacao_dou"
    t.string  "descricao"
    t.string  "nome"
    t.boolean "obriga_plano_trabalho"
  end

end
