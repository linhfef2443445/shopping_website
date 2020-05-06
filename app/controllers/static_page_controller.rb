# frozen_string_literal: true

class StaticPageController < ApplicationController
  def index
    @products = Product.order(created_at: :desc).limit(::Settings.products)
    @top_products = Product.all.order_by_avg_rating
    @cart.cart_total
    @random_products = Product.order("RAND()").limit(::Settings.products)
  end
end
