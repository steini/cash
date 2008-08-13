class ChangeAmountColumnInEntries < ActiveRecord::Migration
  def self.up
    change_column :entries, :amount, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :entries, :amount, :integer
  end
end
