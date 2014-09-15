require "acceptance_helper"

resource "Folders" do
  include_context :api

  get "/folders" do
    response_field :folders,  "Folders of the system"
    response_field :id,    "Folder id",    scope: :folders
    response_field :name,  "Folder name",  scope: :folders

    let!(:folders) { create_list :folder, 1 }

    example_request "Get folders" do
      folders.each do |folder|
        expect(json_response[:folders]).to include include(
          id: folder.id,
          name: folder.name
        )
      end
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_collection do
        let(:resource_name) { :folders }
      end
    end
  end

  get "/folders/:id" do
    parameter :id,  "Folder id"

    let(:id) { folder.id }

    response_field :folders,  "Folder resource object"
    response_field :id,    "Folder id",    scope: :folders
    response_field :name,  "Folder name",  scope: :folders

    let!(:folder) { create :folder }

    example_request "Get a specific folder" do
      expect(json_response[:folders]).to include(
        id: folder.id,
        name: folder.name
      )
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :folders }
      end
    end
  end

  put "/folders/:id" do
    let(:api_user) { folder_owner }

    parameter :folders,  "Single top-level resource object"
    parameter :id,    "Folder id",     scope: :folders
    parameter :name,  "Folder name",  scope: :folders

    let(:id)   { folder.id }
    let(:name) { "Rspec book" }

    response_field :folders,  "Altered folder"
    response_field :id,    "Altered folder id",    scope: :folders
    response_field :name,  "Altered folder name",  scope: :folders

    let!(:folder) { create :folder, owner: folder_owner }
    let(:folder_owner) { create :user }

    example_request "Update the folder attributes" do
      folder.reload
      expect(folder.name).to eq name
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :folders }
      end

      example_request "returns altered folder object" do
        folder.reload
        expect(json_response[:folders]).to include(
          id: folder.id,
          name: folder.name
        )
      end
    end
  end

  post "/folders" do
    parameter :folders,  "Single top-level resource object"
    parameter :name,  "Folder name",  scope: :folders

    let(:name) { "Science fiction" }

    response_field :folders,  "Created folder"
    response_field :id,    "Created folder id",    scope: :folders
    response_field :name,  "Created folder name",  scope: :folders

    example "Create folder" do
      expect do
        do_request
      end.to change { Folder.count }.by +1
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :created_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :folders }
      end

      example_request "returns created folder object" do
        expect(json_response[:folders]).to include(
          name: name
        )
      end
    end
  end
end
