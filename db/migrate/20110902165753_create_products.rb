class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.string :thumnail_pic
      t.string :content_pic
      t.text :content
      t.integer :price
      t.integer :delivery_state
      t.integer :stock
      t.integer :state

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
