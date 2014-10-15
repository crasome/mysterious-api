class User::SessionSerializer < ActiveModel::Serializer
  self.root = "sessions"
  attributes :identifier

  has_one :user, embed: :objects, embed_namespace: :links
end
