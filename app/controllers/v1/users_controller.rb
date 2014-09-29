module V1
  class UsersController < ApplicationController
    def show
      load_user
      render_model @user
    end

    def create
      build_user
      @user.save
      render_model @user, status: :created, location: @user
    end

    private
    def load_user
      @user = user_scope.find params[:id]
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
