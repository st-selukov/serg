class QuestionPolicy < ApplicationPolicy
  def update?
    user.present? && user.admin || user.present? && user.author_of?(record)
  end

  def create?
    update?
  end

  def destroy?
    update?
  end
end
