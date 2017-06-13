class Answer < ApplicationRecord

  default_scope { order ('best DESC , created_at ASC') }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :not_have_attachment

  def set_best
    Answer.transaction do
      if question.has_the_best_answer?
        answer = question.answers.find_by(best: true)
        answer.update!(best: false)
      end
      update!(best: true)
    end
  end

  def not_have_attachment(attributes)
    attributes['file'].blank?
  end
end
