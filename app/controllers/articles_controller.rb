class ArticlesController < ApplicationController



  def intro
    render :layout => false
  end

  def index
    find_post_first('chakkomi');
  end
  
  def show
    @post = Post.find(params[:id])
    @category = Category.find(:first, :conditions => ["id = ?", @post.category_id])
    @posts_list = @category.posts.paginate(:per_page => 5, :page => params[:page])    

#    @posts_list = @category.posts.all
    respond_to do |format|
      format.html 
      format.js
    end

    
  end
  def notice
    find_posts_all('notice');
  end

  def chakkomi
    find_post_first('chakkomi');
  end
  
  def project
    logger.debug "The object is #{action_name}"
    
    find_posts_all('project');
  end

  def comics
    find_posts_all('comics');
  end
  
  def product
    find_posts_all('artmull');
  end


  def get_list
    @category = Category.find(:first, :conditions => ["name = ?", params[:background_action]])
    @posts_list = @category.posts.paginate(:per_page => 5, :page => params[:page])
#    @posts_list = @category.posts.all
    respond_to do |format|
      format.html { render :layout => false}
    end
  end

  protect_from_forgery
  private


  def find_posts_all(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts_list = @category.posts.paginate(:per_page => 5, :page => params[:page])
    @posts = @category.posts.paginate(:per_page => 3, :page => params[:page])
  end
  def find_post_first(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts
    @post = @posts.find(:first)
  end

end
