# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :product_lists, only: %i[index update]

  def create
    @cart.add_product(params[:product_id])
    session[:cart] = @cart.data
    @cart.cart_total
  end

  def index; end

  def destroy
    @cart.data.delete(params[:id])
    @product_lists = Product.where(id: @cart.data.keys)
  end

  def update
    @cart.data[params[:product][:product_id]] = params[:product][:quantity].to_i
  end

  private

  def product_lists
    @product_lists = Product.where(id: @cart.data.keys)
  end
end
