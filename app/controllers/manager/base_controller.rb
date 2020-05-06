# frozen_string_literal: true

module Manager
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_admin!
    skip_before_action :store_user_location!
  end
end
