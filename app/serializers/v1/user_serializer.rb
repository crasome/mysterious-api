class V1::UserSerializer < ActiveModel::Serializer
  self.root = "users"
  attributes :id, :email
end
