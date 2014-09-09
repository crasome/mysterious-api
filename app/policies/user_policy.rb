class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    owner? || admin?
  end

  private
  def owner?
    user == resource
  end
end
