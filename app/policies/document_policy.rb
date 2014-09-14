class DocumentPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    owner? || admin?
  end
end
