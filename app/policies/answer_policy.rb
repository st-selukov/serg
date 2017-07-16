class AnswerPolicy < ApplicationPolicy
  def update?
    user.present? && user.admin || user.present? && user == record.user
  end

  def destroy?
    user.present? && user.admin || user.present? && user == record.user
  end
end
