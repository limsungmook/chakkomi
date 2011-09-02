class Post < ActiveRecord::Base
  belongs_to :category

  attr_accessible :category_id, :title, :body_pic, :body_txt

  validates :body_pic, :presence => true

  default_scope :order => 'posts.created_at DESC'
end
