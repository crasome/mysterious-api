class V1::ExpenseSerializer < ActiveModel::Serializer
  self.root = "expenses"
  attributes :id, :description, :amount, :time, :comment

  has_one :owner, key: :owner, embed_namespace: :links
end
