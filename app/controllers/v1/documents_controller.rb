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

    def update
      load_document
      build_document

      if @document.save
        render json: @document
      else
        render_errors @document
      end
    end

    private
    def load_documents
      @documents = policy_scope document_scope
    end

    def load_document
      @document = document_scope.find params[:id]
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
