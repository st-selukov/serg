class CommentPolicy < ApplicationPolicy
  def destroy?
    user.present? && user.admin || user.present? && user == record.user
  end
end
