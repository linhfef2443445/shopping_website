# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(::Settings.products)
    @filter = Product.ransack(params[:q])
    @filter.sorts = "price desc" if @filter.sorts.blank?
    @products_filter = @filter.result(distinct: true).page(params[:page]).per(::Settings.products)
    @products_search = @search.result.page(params[:page]).per(::Settings.products)
    @top_products = Product.all.order_by_avg_rating.limit(::Settings.limit)
  end

  def show
    @product = Product.find(params[:id])
    @another_products = Product.limit(::Settings.thumbs).find(Product.pluck(:id))
    @thumbs = @product.images.all
    @reviews = @product.reviews.order("created_at asc")
    @review = @product.reviews.build
  end
end
