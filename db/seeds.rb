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

@category = Category.create! :name => 'intro', :detail => '착곰이 시작 페이지입니다. 시작시 이 페이지가 로딩됩니다. 1페이지만 출력합니다.'
@post = @category.posts.create! :title => '첫번째 소개 테스트입니다.', :body_txt => '시작시 로딩되는 소개 페이지입니다. 1페이지만 출력되며 이것을 바꾸려면 임대리에게 말씀해주세요 ^-^; 새 글을 작성하면 자동으로 새로운 페이지가 출력됩니다.'

@category = Category.create! :name => 'notice', :detail => 'Notice 페이지입니다. NOTICE에 해당되는 페이지로, 우선은 전체페이지 출력입니다.'
@post = @category.posts.create! :title => 'Notice 테스트', :body_txt => 'Notice 페이지입니다. 최신 순서로 전체 페이지 출력이고, 이에 대한 옵션 변경은 임대리에게 말씀해주세요^-^'

@category = Category.create! :name => 'chakkomi', :detail => 'CHAKKOMI 페이지입니다. 우선은 전체페이지 출력입니다.'
@post = @category.posts.create! :title => 'chakkomi 테스트', :body_txt => 'chakkomi 페이지입니다. 최신 순서로 전체 페이지 출력이고, 이에 대한 옵션 변경은 임대리에게 말씀해주세요^-^'

@category = Category.create! :name => 'project', :detail => 'project 페이지입니다. 우선은 전체페이지 출력입니다.'
@post = @category.posts.create! :title => 'project 테스트', :body_txt => 'project 페이지입니다. 최신 순서로 전체 페이지 출력이고, 이에 대한 옵션 변경은 임대리에게 말씀해주세요^-^'

@category = Category.create! :name => 'comics', :detail => 'comics 페이지입니다. 우선은 전체페이지 출력입니다.'
@post = @category.posts.create! :title => 'comics 테스트', :body_txt => 'comics 페이지입니다. 최신 순서로 전체 페이지 출력이고, 이에 대한 옵션 변경은 임대리에게 말씀해주세요^-^'

@category = Category.create! :name => 'artmull', :detail => 'artmull 페이지입니다. 우선은 전체페이지 출력입니다.'
@post = @category.posts.create! :title => 'artmull 테스트', :body_txt => 'artmull 페이지입니다. 최신 순서로 전체 페이지 출력이고, 이에 대한 옵션 변경은 임대리에게 말씀해주세요^-^'

@product = Product.create! :title => 'test', :thumnail_pic => '/images/thumnail1.png', :content => 'hello', :price => '5000', :stock => '1', :delivery_state => '일반우편', :state => '판매중'

