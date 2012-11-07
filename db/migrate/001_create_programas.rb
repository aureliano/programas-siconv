class CreateProgramas < ActiveRecord::Migration
  def self.up
    create_table :programas do |t|
      t.integer :id_programa
      t.string :acao_orcamentaria
      t.boolean :aceita_emenda_parlamentar
      t.string :cod_programa_siconv
      t.date :data_disponibilizacao
      t.date :data_fim_beneficiario_especifico
      t.date :data_fim_emenda_parlamentar
      t.date :data_fim_recebimento_propostas
      t.date :data_inicio_beneficiario_especifico
      t.date :data_inicio_emenda_parlamentar
      t.date :data_inicio_recebimento_propostas
      t.date :data_publicacao_dou
      t.string :descricao
      t.string :nome
      t.boolean :obriga_plano_trabalho
    end
  end

  def self.down
    drop_table :programas
  end
end
