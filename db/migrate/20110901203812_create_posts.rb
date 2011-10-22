class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :category_id  # foreign key
      t.string :title
      t.text :body_txt
      t.string :upload_file_name 
      t.string :upload_content_type
      t.integer :upload_file_size
      t.datetime :upload_updated_at

      t.timestamps
    end

    add_index :posts, :category_id
  end

  def self.down
    drop_table :posts
  end
end
