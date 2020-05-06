# frozen_string_literal: true

module Manager
  class SessionsController < Devise::SessionsController
    layout "layoutlogin"

    def after_sign_in_path_for(_resource)
      manager_users_path
    end

    def after_sign_out_path_for(resource)
      stored_location_for(resource) || manager_root_url
    end
  end
end
