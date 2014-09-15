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

  describe "authorization" do
    it "forces to authorize for each action except index" do
      (described_class::ACTIONS - [:index]).each do |action|
        create_routes get: action
        expect do
          get action
        end.to raise_error Pundit::AuthorizationNotPerformedError # for index action it raises the policy_scope error
      end
    end

    it "forces to filter elements on index action" do
      create_routes get: :index
      expect do
        get :index
      end.to raise_error Pundit::PolicyScopingNotPerformedError
    end

    it "does not blow up for authorized users" do
      user = create :user, :admin
      allow(subject).to receive(:resource) { user }

      sign_in user
      create_routes get: :show
      described_class.before_action :authorize_test_user

      expect do
        get :show
      end.not_to raise_error

      described_class.skip_before_action :authorize_test_user
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
