module V1
  class FoldersController < ApplicationController
    def index
      load_folders
      render json: @folders
    end

    def show
      load_folder
      authorize_folder
      render_model @folder
    end

    def update
      load_folder
      authorize_folder
      build_folder
      @folder.save
      render_model @folder
    end

    def create
      build_folder
      authorize_folder
      @folder.save
      render_model @folder, status: :created, location: @folder
    end

    private
    def load_folders
      @folders = policy_scope folder_scope
    end

    def load_folder
      @folder = folder_scope.find params[:id]
    end

    def authorize_folder
      authorize @folder
    end

    def build_folder
      @folder ||= folder_scope.build
      @folder.attributes = folder_params
    end

    def folder_params
      params.require(:folders).permit(:name)
    end

    def folder_scope
      Folder.all
    end
  end
end
