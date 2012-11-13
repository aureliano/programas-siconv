class AddOrgaoVinculadoToProgramas < ActiveRecord::Migration
  def self.up
    change_table :programas do |t|
      t.integer :orgao_vinculado_id
    end
  end

  def self.down
    change_table :programas do |t|
      t.remove :orgao_vinculado_id
    end
  end
end
