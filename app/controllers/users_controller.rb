class UsersController < ApplicationController
  def index
    load_users
    render json: { users: @users }
  end

  private
  def load_users
    @users = user_scope.to_a
  end

  def user_scope
    User.all
  end
end
