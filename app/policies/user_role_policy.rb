class UserRolePolicy < ApplicationPolicy
  
  def create?
    user.is_admin_of? record.resource	
  end

  def update?
    user.is_admin_of? record.resource
  end

  def destroy?
    user.is_admin_of? record.resource || user == record.user 
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end