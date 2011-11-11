class Wallpaper < ActiveRecord::Base

  attr_accessible :year, :month, :count, :wallpaper_zip, :wallpaper_thumb

  validates :year, :presence => true
  validates :month, :presence => true
  validates :wallpaper_zip, :presence => true
  validates :wallpaper_thumb, :presence => true
  has_attached_file :wallpaper_zip
  has_attached_file :wallpaper_thumb,
  :styles => {
    :thumb => "115x90>"}
end
