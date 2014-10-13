# TODO: add more error codes in real app
class RecordErrorsSerializer < ActiveModel::Serializer
  self.root = "errors"
  attributes :status, :title, :detail, :links

  def status
    422
  end

  def title
    "Validation error"
  end

  def detail
    object.errors.full_messages.join(", ")
  end

  # HACK
  def links
    { object.class.model_name.singular_route_key => object.errors.messages }
  end
end
