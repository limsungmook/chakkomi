class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :item_category_id
      t.string :title
      t.text :content
      t.integer :price
      t.string :delivery_state
      t.integer :stock
      t.integer :default_stock
      t.string :state

      t.timestamps
    end
    add_index :products, :item_category_id
  end

  def self.down
    drop_table :products
  end
end
