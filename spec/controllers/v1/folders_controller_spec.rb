require "rails_helper"

describe V1::FoldersController do
  let(:user) { create :user, :registered }
  before { sign_in user  }

  describe "create" do
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

    it "sets current user as owner" do
      post :create, format: :jsonapi, folders: {
        name: folder.name
      }
      created_folder = Folder.find json_response[:folders][:id]
      expect(created_folder.owner).to eq user
    end
  end
end
