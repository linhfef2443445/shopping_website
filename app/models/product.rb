# frozen_string_literal: true

class Product < ApplicationRecord
  extend FriendlyId
  belongs_to :admin
  has_many :order_items, dependent: :destroy
  has_many :images, as: :imageable
  has_many :reviews
  friendly_id :slug_candidates, use: %i[slugged finders]

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  accepts_nested_attributes_for :images

  scope :order_by_avg_rating, lambda {
    select("products.id, avg(reviews.rate) AS avg_rating, name, slug ,price")
      .joins(:reviews).group("products.id").order("avg_rating DESC")
  }

  after_create :remake_slug
  def slug_candidates
    [
      name,
      [name, :id]
    ]
  end

  def remake_slug
    update_attribute(:slug, nil)
    save!
  end

  def avg_rating
    reviews.average(:rate)
  end
end
