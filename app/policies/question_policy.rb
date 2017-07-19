class QuestionPolicy < ApplicationPolicy
  def update?
    user.present? && user.admin || user.present? && user.author_of?(record)
  end

  def destroy?
    update?
  end
end
