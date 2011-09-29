class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.string :name
      t.text :detail
      t.integer :order

      t.timestamps
    end
    def self.down
    drop_table :item_categories
  end

  end
end
