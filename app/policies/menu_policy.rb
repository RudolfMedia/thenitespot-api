class MenuPolicy < ApplicationPolicy

  def create?
    user.can_update? record.spot
  end

  def update?
    user.can_update? record.spot
  end

  def destroy?
    user.can_update? record.spot
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
