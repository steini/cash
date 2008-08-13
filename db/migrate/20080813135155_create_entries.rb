class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :amount
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
