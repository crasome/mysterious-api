class V1::FolderSerializer < ActiveModel::Serializer
  self.root = "folders"
  attributes :id, :name
end
