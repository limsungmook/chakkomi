class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :item_category_id
      t.string :title
      t.text :content
      t.integer :price
      t.integer :stock
      t.integer :default_stock
      t.string :state

      t.string :thumnail_pic_file_name
      t.string :thumnail_pic_content_type
      t.integer :thumnail_pic_file_size
      t.datetime :thumnail_pic_updated_at

      t.string :detail_pic_file_name
      t.string :detail_pic_content_type
      t.integer :detail_pic_file_size
      t.datetime :detail_pic_updated_at
      
      t.timestamps
    end
    add_index :products, :item_category_id
  end

  def self.down
    drop_table :products
  end
end
