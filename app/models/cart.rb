# frozen_string_literal: true

class Cart
  attr_reader :data

  def initialize(cart_data)
    @data = cart_data || {}
  end

  def add_product(product_id)
    @data[product_id] ||= 0
    @data[product_id] += 1
  end

  def cart_total
    products = Product.where(id: data.keys).pluck(:id, :price).to_h
    result = data.reduce(0) do |total, (key, value)|
      total += (value * products[key.to_i])
    end
  end
end
