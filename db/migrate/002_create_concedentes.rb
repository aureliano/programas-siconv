class CreateConcedentes < ActiveRecord::Migration
  def self.up
    create_table :concedentes do |t|
      t.integer :orgao_id
      t.string :nome
    end
  end

  def self.down
    drop_table :concedentes
  end
end
