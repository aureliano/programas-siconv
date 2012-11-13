class AddOrgaoMandatarioToProgramas < ActiveRecord::Migration
  def self.up
    change_table :programas do |t|
      t.integer :orgao_mandatario_id
    end
  end

  def self.down
    change_table :programas do |t|
      t.remove :orgao_mandatario_id
    end
  end
end
