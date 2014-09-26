require "rails_helper"

class TestableController < V1::ApplicationController
  ACTIONS = %i[create update destroy show index]

  ACTIONS.each do |action|
    define_method(action) {  }
  end

  private
  def authorize_test_user
    authorize resource
  end
  def resource; end
end

describe TestableController do
  after { Rails.application.reload_routes! }

  describe "authentication" do
    it "requests authentication for clients that failed authentication" do
      create_routes get: :show
      sign_in build_stubbed :user # user is not saved so her credentials are invalid

      expect(subject).to receive :request_http_basic_authentication
      get :show
    end
  end

  private
  def create_routes(routes)
    Rails.application.routes.draw do
      routes.each do |method, action|
        send method, '/test_me' => "testable##{action}"
      end
      resources :users
    end
  end
end
