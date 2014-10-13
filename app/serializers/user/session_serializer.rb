class User::SessionSerializer < ActiveModel::Serializer
  self.root = "sessions"
  has_one :user, embed: :objects, embed_namespace: :links
end
