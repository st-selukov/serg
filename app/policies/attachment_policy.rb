class AttachmentPolicy < ApplicationPolicy
  def destroy?
    user.present? && user.admin || user.present? && user == record.attachable.user
  end
end
