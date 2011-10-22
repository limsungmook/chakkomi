class CreateWallpapers < ActiveRecord::Migration
  def self.up
    create_table :wallpapers do |t|
      t.integer :year
      t.integer :month
      t.integer :count

      t.string :wallpaper_zip_file_name
      t.string :wallpaper_zip_content_type
      t.integer :wallpaper_zip_file_size
      t.datetime :wallpaper_zip_updated_at
      
      t.string :wallpaper_thumb_file_name
      t.string :wallpaper_thumb_content_type
      t.integer :wallpaper_thumb_file_size
      t.datetime :wallpaper_thumb_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :wallpapers
  end
end
