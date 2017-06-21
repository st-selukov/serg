class Answer < ApplicationRecord
  include Attachable
  include Votable
  include Constants

  default_scope { order ('best DESC , created_at ASC') }

  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  after_save :up_owner_reputation

  def set_best
    Answer.transaction do
      if question.has_the_best_answer?
        answer = question.answers.find_by(best: true)
        answer.update!(best: false)
      end
      update!(best: true)
    end
  end

  def up_owner_reputation
    user.change_reputation(YOU_PLACED_QUESTION_OR_ANSWER)
  end
end
