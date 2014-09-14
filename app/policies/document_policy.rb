class DocumentPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    owner? || admin?
  end

  def create?
    registered?
  end
end
