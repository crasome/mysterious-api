class ApplicationPolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def scope
    Pundit.policy_scope!(user, resource.class)
  end

  def admin?
    user.admin?
  end

  def owner?
    resource.owner == user
  end

  def registered?
    user.is_a? User
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

