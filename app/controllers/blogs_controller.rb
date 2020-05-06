class BlogsController < ApplicationController
  before_action :recent_blogs, only: [:index, :show]
  def index
    @blogs = Blog.all.order(created_at: :desc).page(params[:page]).per(::Settings.blogs)
  end

  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments.order("created_at asc")
    @comment = @blog.comments.build
  end

  private

  def recent_blogs
    @recent_blogs = Blog.last(5).reverse
  end
end
