# frozen_string_literal: true

module Manager
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_admin!
    skip_before_action :store_user_location!
    
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html { redirect_to manager_blogs_path, alert: exception.message }
      end
    end

    def current_ability
      @current_ability ||= Ability.new(current_admin)
    end
  end
end
