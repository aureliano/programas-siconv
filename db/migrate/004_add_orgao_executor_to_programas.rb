class AddOrgaoExecutorToProgramas < ActiveRecord::Migration
  def self.up
    change_table :programas do |t|
      t.integer :orgao_executor_id
    end
  end

  def self.down
    change_table :programas do |t|
      t.remove :orgao_executor_id
    end
  end
end
