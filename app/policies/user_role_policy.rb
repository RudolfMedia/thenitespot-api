class UserRolePolicy < ApplicationPolicy
  
  def index?
    user.can_update? record
  end

  def create?
    user.is_admin_of? record.spot	
  end

  def update?
    user.is_admin_of? record.spot
  end

  def destroy?
    user.is_admin_of? record.spot || user == record.user 
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end