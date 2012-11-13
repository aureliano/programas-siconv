class AddOrgaoSuperiorToConcedentes < ActiveRecord::Migration
  def self.up
    change_table :concedentes do |t|
      t.integer :orgao_superior
    end
  end

  def self.down
    change_table :concedentes do |t|
      t.remove :orgao_superior
    end
  end
end
