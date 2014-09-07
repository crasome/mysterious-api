class UsersController < ApplicationController
  def index
    load_users
    render json: @users
  end

  def show
    load_user
    render json: @user
  end

  private
  def load_users
    @users = user_scope.to_a
  end

  def load_user
    @user = user_scope.find params[:id]
  end

  def user_scope
    User.all
  end
end
