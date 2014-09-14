class V1::DocumentSerializer < ActiveModel::Serializer
  self.root = "documents"
  attributes :id, :name
end
