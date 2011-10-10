class ArticlesController < ApplicationController


  def notice
    @posts = find_posts_all('notice');
  end
  
  def chakkomi
    @post = find_post_first('chakkomi');
  end
  
  def project
    @posts = find_posts_all('project');
  end

  def comics
    @posts = find_posts_all('comics');
  end
  
  def product
    @posts = find_posts_all('artmull');
  end



  protect_from_forgery
  private


  def find_posts_all(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts.paginate(:per_page => 5, :page => params[:page])
  end
  def find_post_first(category_name)
    @category = Category.find(:first, :conditions => ["name = ?", category_name]) 
    @posts = @category.posts
    @post = @posts.find(:first)
  end


end
