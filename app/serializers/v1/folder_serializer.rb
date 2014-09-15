class V1::FolderSerializer < ActiveModel::Serializer
  self.root = "folders"
  attributes :id, :name

  has_one  :owner,      key: :owner,      embed_namespace: :links
  has_many :documents,  key: :documents,  embed_namespace: :links
end
