# frozen_string_literal: true

class Cart
  attr_reader :data
  def initialize(cart_data)
    @data = cart_data || {}
  end

  def add_product(stt, product_id, size)
    @data[stt] ||= {}
    if size == nil
      size = 0
    end
    @data[stt][product_id] = [size.to_i, 1]
  end

  def cart_total
    total = 0
    self.data.keys.each do |val|
      total += Product.find_by(id: data[val.to_s].keys).price * data[val.to_s].values.first.last
    end
    return total
  end

  def find_product(id)
    self.data[id.to_s]
  end

  def size_present(id, size)
    array = self.data.select{|key, hash| hash.keys.include?(id.to_s)}
    array.values.map{|n| n[id.to_s].first}.include?(size.to_i)
  end
end
