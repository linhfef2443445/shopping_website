# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :product_lists, only: %i[index update]

  def create
    if @cart.size_present(params[:product_id], params[:size])
      respond_to do |format|
        format.js
      end      
    else
      @sttafter = @cart.data.keys.last.to_i + 1
      if params[:stt] == nil
        @cart.add_product(@sttafter.to_s, params[:product_id], params[:size])
      else
        @cart.add_product(params[:stt], params[:product_id], params[:size])
      end
      session[:cart] = @cart.data
      @cart.cart_total
    end
  end

  def index; end

  def destroy
    @cart.data.delete(params[:id])
    n = 1
    @cart.data.dup.each do |val|
      @cart.data[n.to_s] = @cart.data.delete val.first
      n += 1
    end
    array = @cart.data.values.map {|n| n.first}
    i = 0
    stt = @cart.data.keys[i].to_i
    lists = []
    array.each do |n|
      lists[i] = [Product.find_by(id: n),stt]
      i += 1
      stt += 1
    end
    @product_lists = lists
  end

  def update
    if params[:quantity] == nil
      @cart.data[params[:id]][params[:product_id]][0] = params[:size].to_i
    else
      @cart.data[params[:id]][params[:product_id]][1] = params[:quantity].to_i
    end
  end

  private

  def product_lists
    array = @cart.data.values.map {|n| n.first}
    i = 0
    stt = @cart.data.keys[i].to_i
    lists = []
    array.each do |n|
      lists[i] = [Product.find_by(id: n),stt]
      i += 1
      stt += 1
    end
    @product_lists = lists
  end
end
