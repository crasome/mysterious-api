require "rails_helper"

describe V1::DocumentsController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

  describe "create" do
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

    it "sets current user as owner" do
      post :create, format: :jsonapi, documents: {
        name: document.name
      }
      created_document = Document.find json_response[:documents][:id]
      expect(created_document.owner).to eq user
    end
  end
end
