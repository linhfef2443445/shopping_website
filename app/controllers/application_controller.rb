# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :cart
  helper_method :cart
  before_action :store_user_location!, if: :storable_location?
  before_action :search

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def search
    @search = Product.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:user_name, :full_name, :phone_number, :address,
               :email, :password, :password_confirmation)
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_url
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
