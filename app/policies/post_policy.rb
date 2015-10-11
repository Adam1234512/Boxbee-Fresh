class PostPolicy < ApplicationPolicy
  def authorized_poster
    user.present? && (user.has_role?(:admin) || user.has_role?(:editor))
  end

  def create?
    authorized_poster
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def preview?
    create?
  end

  class Scope < Scope
    def resolve
      if user.present? && (user.has_role?(:admin) || user.has_role?(:editor))
        scope.all
      else
        scope.where(status: :published)
      end
    end
  end
end
