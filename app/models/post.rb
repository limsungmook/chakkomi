class Post < ActiveRecord::Base
  belongs_to :category

  attr_accessible :category_id, :title, :body_txt, :upload

#  validates :body_pic, :presence => true

  default_scope :order => 'posts.created_at DESC'

  has_attached_file :upload
end
