# frozen_string_literal: true

class OrderItem < ApplicationRecord
  enum size: %i[S M L]
  belongs_to :order
  belongs_to :product
end
