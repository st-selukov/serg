class CommentPolicy < ApplicationPolicy
  def destroy?
    user.present? && user.admin || user.present? && user.author_of?(record)
  end
end
