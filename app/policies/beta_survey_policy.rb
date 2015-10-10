class BetaSurveyPolicy < ApplicationPolicy
  def show?
    user.present? && user.has_role?(:admin)
  end
end
