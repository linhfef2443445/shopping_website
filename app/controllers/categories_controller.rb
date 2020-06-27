class CategoriesController < ApplicationController
  def show
    @category = Category.find params[:id]
    @products = @category.products.page(params[:page]).per(20)
    @filter = Product.ransack(params[:q])
    @top_products = Product.all.order_by_avg_rating.limit(::Settings.limit)
  end
end
