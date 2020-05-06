# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user_name, presence: true, length: { maximum: 50 }
  validates :full_name, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, length: { minimum: 10 }
  validates :address, presence: true, length: { maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
