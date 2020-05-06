# frozen_string_literal: true

class Admin < ApplicationRecord
  enum role: %i[admin contributor]
  has_many :products
  has_many :blogs

  validates :user_name, presence: true, length: { minimum: 4, maximum: 10 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
