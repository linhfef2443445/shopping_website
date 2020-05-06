# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:quantity) }

  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
end
