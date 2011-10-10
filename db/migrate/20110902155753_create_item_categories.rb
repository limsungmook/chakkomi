class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string :name
      t.text :detail
      t.integer :order

      t.string :thumnail_pic_file_name
      t.string :thumnail_pic_content_type
      t.integer :thumnail_pic_file_size
      t.datetime :thumnail_pic_updated_at

      t.timestamps
    end
    def self.down
    drop_table :item_categories
  end

  end
end
