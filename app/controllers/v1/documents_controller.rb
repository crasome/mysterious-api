module V1
  class DocumentsController < ApplicationController
    def index
      load_documents
      render json: @documents
    end

    def show
      load_document
      render json: @document
    end

    private
    def load_documents
      @documents = policy_scope document_scope
    end

    def load_document
      @document = document_scope.find params[:id]
      authorize @document
    end

    def document_scope
      Document.all
    end
  end
end
