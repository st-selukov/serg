class Question < ApplicationRecord

  default_scope { order ('created_at DESC') }

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :title, :body, presence: true
  validates :title, length: { in: 5..140 }

  accepts_nested_attributes_for :attachments, reject_if: :not_have_attachment

  def has_the_best_answer?
    answers.exists?(best: true) ? true : false
  end

  def not_have_attachment(attributes)
    attributes['file'].blank?
  end
end
