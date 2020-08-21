# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart

  def create
    @order = current_user.orders.build(checkout_params)
    cart.data.values.each do |product|
      @order.order_items.build(product_id: product.keys.first.to_i, quantity: product.values.first.second, size: product.values.first.first)
    end
    if @order.save
      flash[:success] = "Order created complete!"
      cart.data.clear
      redirect_to billings_path
    else
      render "new"
    end
  end

  def new
    array = @cart.data.values.map {|n| n.first}
    i = 0
    stt = @cart.data.keys[i].to_i
    lists = []
    array.each do |n|
      lists[i] = [Product.find_by(id: n),stt]
      i += 1
      stt += 1
    end
    @products = lists
    @order = current_user.orders.new
  end

  private

  def check_cart
    if cart.data.empty?
      redirect_to carts_path 
      flash[:error] = "No order items!"
    end
  end

  def checkout_params
    params.require(:order).permit(:full_name, :address, :phone_number)
  end
end
