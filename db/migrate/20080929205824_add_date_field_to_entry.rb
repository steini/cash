class AddDateFieldToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :date, :date
  end

  def self.down
    remove_column :entries, :date
  end
end
