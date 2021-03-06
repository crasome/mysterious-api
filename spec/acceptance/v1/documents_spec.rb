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
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_collection do
        let(:resource_name) { :documents }
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
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :documents }
      end
    end
  end

  put "/documents/:id" do
    let(:api_user) { document_owner }

    parameter :documents,  "Single top-level resource object"
    parameter :id,    "Document id",     scope: :documents
    parameter :name,  "Document name",  scope: :documents

    let(:id)   { document.id }
    let(:name) { "Rspec book" }

    response_field :documents,  "Altered document"
    response_field :id,    "Altered document id",    scope: :documents
    response_field :name,  "Altered document name",  scope: :documents

    let!(:document) { create :document, owner: document_owner }
    let(:document_owner) { create :user }

    example_request "Update the document attributes" do
      document.reload
      expect(document.name).to eq name
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :ok_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :documents }
      end

      example_request "returns altered document object" do
        document.reload
        expect(json_response[:documents]).to include(
          id: document.id,
          name: document.name
        )
      end
    end
  end

  post "/documents" do
    parameter :documents,  "Single top-level resource object"
    parameter :name,  "Document name",  scope: :documents

    let(:name) { "Rspec book" }

    response_field :documents,  "Created document"
    response_field :id,    "Created document id",    scope: :documents
    response_field :name,  "Created document name",  scope: :documents

    example "Create document" do
      expect do
        do_request
      end.to change { Document.count }.by +1
    end

    describe "response", :no_doc do
      include_context :json
      include_examples :created_request
      it_behaves_like :publicly_accessible_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :documents }
      end

      example_request "returns created document object" do
        expect(json_response[:documents]).to include(
          name: name
        )
      end
    end
  end
end
