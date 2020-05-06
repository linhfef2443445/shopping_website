# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :file, ImageLinkUploader
end
