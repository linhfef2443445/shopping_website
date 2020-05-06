# frozen_string_literal: true

require "rails_helper"

RSpec.describe Order, type: :model do
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:full_name) }

  it { should validate_length_of(:address).is_at_most(150) }
  it { should validate_length_of(:phone_number).is_at_least(10) }
  it { should validate_length_of(:full_name).is_at_most(50) }
end
