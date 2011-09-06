# -*- coding: utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.delete_all
Post.delete_all
Category.delete_all

@user1 = User.create! :email => 'ipes4579@gmail.com', :password => '12345678', :password_confirmation => '12345678'
@user1.confirm!
@user2 = User.create! :email => 'chakkomi@chakkomi.com', :password => '12345678', :password_confirmation => '12345678'
@user2.confirm!


 @category = Category.create! :name => 'intro', :detail => '착곰이 소개 페이지입니다.'
 @post = @category.posts.create! :title => '소개입니다', :body_txt => '착곰이 소개입니다' ,:body_pic => File.open('public/images/intro20110903.png')
 @category = Category.create! :name => 'artmull', :detail => '착곰이 창작물 페이지입니다.'
 @post = @category.posts.create! :title => '창작물입니다', :body_pic => File.open('public/images/artmull20110903.png'), :body_txt => '착곰이 창작물입니다'

 @category = Category.create! :name => 'store', :detail => '착곰이 샵 페이지입니다.'

