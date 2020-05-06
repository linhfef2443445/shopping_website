# frozen_string_literal: true

module Manager
  class UsersController < Manager::BaseController
    def index
      @users = User.page params[:page]
    end
  end
end
