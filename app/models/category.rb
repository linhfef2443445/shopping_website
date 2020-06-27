class Category < ApplicationRecord
  has_many :products
  belongs_to :admin
  validates :name, presence: true, uniqueness: true
end
