module V1
  class DocumentsController < ApplicationController
    def index
      load_documents
      render json: @documents
    end

    private
    def load_documents
      @documents = policy_scope document_scope
    end

    def document_scope
      Document.all
    end
  end
end
