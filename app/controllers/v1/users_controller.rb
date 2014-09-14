module V1
  class UsersController < ApplicationController
    def index
      load_users
      render json: @users
    end

    def show
      load_user
      render json: @user
    end

    def update
      load_user
      build_user

      if @user.save
        render json: @user
      else
        render_errors @user
      end
    end

    private
    def load_users
      @users = policy_scope user_scope
    end

    def load_user
      @user = user_scope.find params[:id]
      authorize @user
    end

    def build_user
      @user ||= user_scope.build
      @user.attributes = user_params
    end

    def user_params
      params.require(:users).permit(:email)
    end

    def user_scope
      User.all
    end
  end
end
