class ImagePolicy < ApplicationPolicy
 
  def create?
    user.can_update?(record.imageable) || user.can_update?(record.imageable.spot)
  end

  def update?
    user.can_update?(record.imageable) || user.can_update?(record.imageable.spot)
  end

  def destroy?
    user.can_update?(record.imageable) || user.can_update?(record.imageable.spot)
  end


  class Scope < Scope
    def resolve
      scope
    end
  end
end 
