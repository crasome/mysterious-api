module V1
  class DocumentsController < ApplicationController
    def index
      load_documents
      render json: @documents
    end

    def show
      load_document
      authorize_document
      render_model @document
    end

    def update
      load_document
      authorize_document
      build_document
      @document.save
      render_model @document
    end

    def create
      build_document
      authorize_document
      @document.save
      render_model @document, status: :created
    end

    private
    def load_documents
      @documents = policy_scope document_scope
    end

    def load_document
      @document = document_scope.find params[:id]
    end

    def authorize_document
      authorize @document
    end

    def build_document
      @document ||= document_scope.build
      @document.attributes = document_params
    end

    def document_params
      params.require(:documents).permit(:name)
    end

    def document_scope
      Document.all
    end
  end
end
