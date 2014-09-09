class User::Guest < ActiveType::Object

  attribute :email, :string, default: proc { "guest@example.com" }
  attribute :admin, :boolean, default: proc { false }
end
