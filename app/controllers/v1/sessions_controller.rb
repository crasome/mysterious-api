module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate, only: :create

    def create
      build_session
      @session.save
      render_model @session, status: :created
    end

    private
    def build_session
      @session ||= session_scope.build
      @session.attributes = session_params
    end

    def session_params
      params.require(:sessions).permit(:identifier, :password)
    end

    def session_scope
      User::Session.all
    end
  end
end
