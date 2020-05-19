# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :admin
  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validates :title, presence: true

  mount_uploader :image, ImageLinkUploader
end
