class AddOrgaoSuperiorToProgramas < ActiveRecord::Migration
  def self.up
    change_table :programas do |t|
      t.integer :orgao_superior_id
    end
  end

  def self.down
    change_table :programas do |t|
      t.remove :orgao_superior_id
    end
  end
end
