class UsersController < ApplicationController
  def index
    render json: { users: [] }
  end
end
