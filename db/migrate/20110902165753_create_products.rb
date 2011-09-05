class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.text :content
      t.integer :price
      t.string :delivery_state
      t.integer :stock
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
