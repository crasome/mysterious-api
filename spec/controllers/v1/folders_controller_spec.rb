require "rails_helper"

describe V1::FoldersController do
  describe "create" do
    before { sign_in create :user, :registered }
    let(:folder) { build_stubbed :folder }

    it "responds with :created" do
      post :create, format: :jsonapi, folders: {
        name: folder.name
      }
      expect(response).to have_http_status :created
    end

    it "includes location header" do
      post :create, format: :jsonapi, folders: {
        name: folder.name
      }
      expect(response.headers).to include "Location" => /folders\/[\d+]/
    end
  end
end
