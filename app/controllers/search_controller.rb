class SearchController < ApplicationController
  def index
    q = params[:q]
    @product = Product.search(name_cont: q).result
    @blog = Blog.search(title_cont: q).result
    @result = @blog + @product
    @result = Kaminari.paginate_array(@result).page(params[:page]).per(10)
  end
end
