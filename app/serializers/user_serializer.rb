class UserSerializer < ActiveModel::Serializer
  self.root = "users"
  attributes :id, :email
end
