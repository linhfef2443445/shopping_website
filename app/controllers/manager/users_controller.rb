# frozen_string_literal: true

module Manager
  class UsersController < Manager::BaseController
    def index
      @users = User.all
    end
  end
end
