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

@chakkomi = User.create! :email => 'chakkomi@google.com', :password => '123456', :name => '착곰이', :weburl => 'http://www.chakkomi.com', :shortbio => '착곰이 시드'
@chakkomi.confirm!

@mook = User.create! :email => 'ipes4579@google.com', :password => '123456', :name => '임성묵', :shortbio => '임성묵'
@mook.confirm!

 @category = Category.create! :name => 'intro', :detail => '착곰이 소개 페이지입니다.'
 @post = @category.posts.create! :title => '소개입니다', :body_pic => '/images/intro20110903.png', :body_txt => '착곰이 소개입니다'

 @category = Category.create! :name => 'history', :detail => '착곰이 역사 페이지입니다.'
 @post = @category.posts.create! :title => '역사입니다', :body_pic => '/images/history20110903.png', :body_txt => '착곰이 역사입니다'
 
 @category = Category.create! :name => 'artmull', :detail => '착곰이 창작물 페이지입니다.'
 @post = @category.posts.create! :title => '창작물입니다', :body_pic => '/images/artmull20110903.png', :body_txt => '착곰이 창작물입니다'

 @category = Category.create! :name => 'store', :detail => '착곰이 샵 페이지입니다.'

