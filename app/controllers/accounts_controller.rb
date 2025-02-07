# -*- coding: utf-8 -*-

class AccountsController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to("/admins", :notice => '유저 변경이 완료되었습니다.') }
#        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
#        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
