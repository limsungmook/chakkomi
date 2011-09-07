# -*- coding: utf-8 -*-

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#User.delete_all
Post.delete_all
Category.delete_all
User.delete_all
Product.delete_all


# @user1 = User.create! :email => 'ipes4579@gmail.com', :password => '12345678', :password_confirmation => '12345678'
# @user1.confirm!
# @user2 = User.create! :email => 'chakkomi@chakkomi.com', :password => '12345678', :password_confirmation => '12345678'
# @user2.confirm!
@connection = ActiveRecord::Base.connection();
@connection.execute("INSERT INTO `users` (
`confirmation_sent_at`, `confirmation_token`, `confirmed_at`, `created_at`, `current_sign_in_at`, `current_sign_in_ip`, `email`, `encrypted_password`, `failed_attempts`, `haslocalpw`, `last_sign_in_at`, `last_sign_in_ip`, `locked_at`, `name`, `remember_created_at`, `reset_password_token`, `shortbio`, `sign_in_count`, `updated_at`, `weburl`) VALUES (
'2011-09-07 16:45:28', NULL, '2011-09-07 16:45:33', '2011-09-07 16:45:28', '2011-09-07 16:45:33', '192.168.10.111', 'ipes4579@gmail.com', '$2a$10$YVD0ajDMkE9D19flkTF7S.YpxCwHZzV1fuzvYXesc51ZqsE/6qW0C', 0, '2011-09-07 16:45:33', '192.168.10.111', NULL, NULL, NULL, NULL, NULL, NULL, 1, '2011-09-07 16:45:33', NULL)");

 @category = Category.create! :name => 'intro', :detail => '착곰이 소개 페이지입니다.'
 @post = @category.posts.create! :title => '소개입니다', :body_txt => '착곰이 소개입니다', :body_pic => '/images/intro20110903.png'
 @category = Category.create! :name => 'artmull', :detail => '착곰이 창작물 페이지입니다.'
 @post = @category.posts.create! :title => '창작물입니다', :body_txt => '착곰이 창작물입니다', :body_pic => '/images/artmull20110903.png'

@product = Product.create! :title => 'test', :thumnail_pic => '/images/thumnail1.png', :content => 'hello', :price => '5000', :stock => '1', :delivery_state => '일반우편', :state => '판매중'

