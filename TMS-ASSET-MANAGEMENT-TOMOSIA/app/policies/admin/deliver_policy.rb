class Admin::DeliverPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: 1)
      end
    end
  end

  def scope
    Pundit.policy_scope!(user, [:admin,record.class])
  end

  def index?
    user.admin? 
  end

  def show?
    user.admin? 
  end

  def edit?
    user.admin? 
  end

  def update?
    user.admin? 
  end

  def create?
    user.admin?
  end
end
