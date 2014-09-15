require "rails_helper"

class TestableController < V1::ApplicationController
  ACTIONS = %i[create update destroy show index]

  ACTIONS.each do |action|
    define_method(action) {  }
  end
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

  describe "authorization" do
    it "is forced on non index actions" do
      (described_class::ACTIONS - [:index]).each do |action|
        create_routes get: action
        expect do
          get action
        end.to raise_error Pundit::AuthorizationNotPerformedError
      end
    end

    it "is forces to filter elements on index action" do
      create_routes get: :index
      expect do
        get :index
      end.to raise_error Pundit::PolicyScopingNotPerformedError
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
