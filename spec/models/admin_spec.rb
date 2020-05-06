# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin, type: :model do
  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_length_of(:user_name).is_at_least(4).is_at_most(10) }
  it { should validate_length_of(:email) }
  it { should validate_length_of(:password) }
end
