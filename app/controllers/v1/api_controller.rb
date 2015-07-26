module V1
  class ApiController < ActionController::Base
    include ActionController::Serialization
    include ActionController::MimeResponds

    protected
    # TODO: extract .render_* methods to module or replace by respond_with
    def render(*)
      respond_to do |format|
        format.jsonapi { super }
        format.json { super }
      end
    end

    def render_errors(model)
      render json: RecordErrorsSerializer.new(model).to_json, status: :unprocessable_entity
    end

    def render_model(model, **options)
      if model.valid?
        return head :no_content if :no_content == options[:status]

        render json: model, **options
      else
        render_errors model
      end
    end
  end
end
