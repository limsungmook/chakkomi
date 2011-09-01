class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :category_id  # foreign key
      t.string :title
      t.string :body_pic
      t.text :body_txt

      t.timestamps
    end

    add_index :posts, :category_id
  end

  def self.down
    drop_table :posts
  end
end
