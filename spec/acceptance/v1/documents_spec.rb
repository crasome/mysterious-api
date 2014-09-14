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
  end
end
