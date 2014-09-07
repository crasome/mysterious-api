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
    save_user or render json: @user.errors, status: :unprocessable_entity
  end

  private
  def load_users
    @users = user_scope.to_a
  end

  def load_user
    @user = user_scope.find params[:id]
  end

  def build_user
    @user ||= user_scope.build
    @user.attributes = user_params
  end

  def save_user
    @user.save.tap do |state|
      render json: @user if state
    end
  end

  def user_params
    params.require(:users).permit(:email)
  end

  def user_scope
    User.all
  end
end
