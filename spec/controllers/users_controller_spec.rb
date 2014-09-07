require "rails_helper"

describe UsersController do
  describe "index" do
    before do
      create :user
      get :index
    end

    include_examples "respect privacy in response"
  end
end
