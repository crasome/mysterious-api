class V1::DocumentSerializer < ActiveModel::Serializer
  self.root = "documents"
  attributes :id, :name

  has_one :owner, key: :owner, embed: :ids, embed_namespace: :links
end
