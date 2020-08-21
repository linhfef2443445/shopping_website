# frozen_string_literal: true

module Manager
  class BlogsController < Manager::BaseController
    before_action :load_blog, only: %i[edit update destroy]
    load_and_authorize_resource

    def index
      @blogs = Blog.order(created_at: :desc)
    end

    def new
      @blog = Blog.new
    end

    def create
      @blog = current_admin.blogs.build(blog_params)
      if @blog.save
        flash[:success] = "Blog was successfully created"
        redirect_to manager_blogs_path
      else
        flash[:error] = "Something went wrong"
        render :new
      end
    end

    def edit; end

    def update
      if @blog.update blog_params
        redirect_to manager_blogs_path, success: "Blog was updated!"
      else
        render :edit
      end
    end

    def destroy
      if @blog.destroy
        redirect_to manager_blogs_path, success: "Blog was destroyed!" 
      end
    end

    private

    def load_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :content, :image, :description)
    end
  end
end
