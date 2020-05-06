# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart

  def create
    @order = current_user.orders.build(checkout_params)
    cart.data.each do |product_id, quantity|
      @order.order_items.build(product_id: product_id, quantity: quantity)
    end
    if @order.save
      flash[:success] = "Order created complete!"
      cart.data.clear
      redirect_to orders_path
    else
      render "new"
    end
  end

  def new
    @products = Product.where(id: @cart.data.keys)
    @order = current_user.orders.new
  end

  private

  def check_cart
    redirect_to carts_path if cart.data.empty?
    flash[:error] = "No order items!"
  end

  def checkout_params
    params.require(:order).permit(:full_name, :address, :phone_number)
  end
end
