require "acceptance_helper"

resource "Documents" do
  include_context :api

  get "/documents" do
    response_field :documents,  "A collection of documents in the system"
    response_field :id,    "Document id",    scope: :documents
    response_field :name,  "Document name",  scope: :documents

    let!(:documents) { create_list :document, 1 }

    example_request "Get documents" do
      documents.each do |document|
        expect(json_response[:documents]).to include include(
          id: document.id,
          name: document.name
        )
      end
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :json_api_collection do
        let(:resource_name) { :documents }
      end
    end

    describe "authorization", :no_doc do
      it_behaves_like :publicly_accessible_request
      it_behaves_like :restricted_request, rejected_roles: []  do
        let(:resource) { documents }
      end
    end
  end

  get "/documents/:id" do
    parameter :id,  "Document id"

    let(:id) { document.id }

    response_field :documents,  "Document resource object"
    response_field :id,    "Document id",    scope: :documents
    response_field :name,  "Document name",  scope: :documents

    let!(:document) { create :document }

    example_request "Get a specific document" do
      expect(json_response[:documents]).to include(
        id: document.id,
        name: document.name
      )
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :documents }
      end
    end

    describe "authorization", :no_doc do
      it_behaves_like :publicly_accessible_request
      it_behaves_like :restricted_request, rejected_roles: []  do
        let(:resource) { document }
      end
    end
  end
end
