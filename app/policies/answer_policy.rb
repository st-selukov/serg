class AnswerPolicy < ApplicationPolicy
  def update?
    user.present? && user.admin || user.present? && user.author_of?(record)
  end

  def destroy?
    update?
  end

  def create?
    update?
  end

  def best_answer?
    user.present? && user.author_of?(record.question)
  end
end
