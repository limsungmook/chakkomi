# -*- coding: utf-8 -*-

class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    if params[:category_id].nil?
      @posts = Post.all
    else
      @posts = Post.find(:all, :conditions => ["category_id = ?", params[:category_id]])
      params[:category_id] = nil
   end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

#      @posts = Post.find(:all)


#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @post }
#    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @post.category_id = params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @category = Category.new(:category_id => params[:category_id])
    @post = @category.posts.build(params[:post])
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@category, :notice => '글 작성이 완료되었습니다.') }
#        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
#        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => '글 수정이 완료되었습니다') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @category = Category.new(:category_id => params[:category_id])
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to @category }
#      format.html { redirect_to(posts_url) }
#      format.xml  { head :ok }
    end
  end
end
