# frozen_string_literal: true

module Manager
  class UsersController < Manager::BaseController
    def index
      @users = User.all
    end
    
    def update
      @users = User.page params[:page]
      user = User.find params[:id]
      if !user.deactivated
        user.update(deactivated: true)
      else
        user.update(deactivated: false)
      end
    end

    private

    def user_params
      params.require(:user).permit(:deactivated)
    end
  end
end
