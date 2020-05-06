# frozen_string_literal: true

module Manager
  class BlogsController < Manager::BaseController
    def index
      @blogs = Blog.page(params[:page])
    end
  end
end
