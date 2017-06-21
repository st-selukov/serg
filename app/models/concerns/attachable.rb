module Attachable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachable, dependent: :destroy

    accepts_nested_attributes_for :attachments, reject_if: :not_have_attachment
  end

  def not_have_attachment(attributes)
    attributes['file'].blank?
  end
end