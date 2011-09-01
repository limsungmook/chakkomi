class Post < ActiveRecord::Base
  belongs_to :category

  attr_accessible :title, :body_pic, :body_txt

  validates :category_id, :presence => true
  validates :body_pic, :presence => true
end
