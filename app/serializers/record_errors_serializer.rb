class RecordErrorsSerializer < ActiveModel::Serializer
  self.root = "errors"
  attributes :status, :title, :detail

  def status
    422
  end

  def title
    "Validation error"
  end

  def detail
    object.errors.full_messages.join(", ")
  end
end
