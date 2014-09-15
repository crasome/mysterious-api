class V1::FolderSerializer < ActiveModel::Serializer
  self.root = "folders"
  attributes :id, :name

  has_one :owner, key: :owner, embed: :ids, embed_namespace: :links
end
