class AttachmentPolicy < ApplicationPolicy
  def destroy?
    user.present? && user.admin ||
        user.present? && user.author_of?(record.attachable)
  end
end
