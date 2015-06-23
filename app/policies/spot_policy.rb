class SpotPolicy < ApplicationPolicy
  
  # def index?
  #   user.can_update? record 
  # end

  def update?
  	user.can_update? record 
  end

  def destroy?
    user.is_admin_of? record 
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
