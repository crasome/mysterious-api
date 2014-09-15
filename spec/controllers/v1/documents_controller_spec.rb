require "rails_helper"

describe V1::DocumentsController do
  describe "create" do
    before { sign_in create :user, :registered }
    let(:document) { build_stubbed :document }

    it "responds with :created" do
      post :create, format: :jsonapi, documents: {
        name: document.name
      }
      expect(response).to have_http_status :created
    end

    it "includes location header" do
      post :create, format: :jsonapi, documents: {
        name: document.name
      }
      expect(response.headers).to include "Location" => /documents\/[\d+]/
    end
  end
end
