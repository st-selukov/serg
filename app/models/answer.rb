class Answer < ApplicationRecord

  default_scope { order ('best DESC , created_at ASC') }

  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  def set_best
    Answer.transaction do
      begin
        if question.has_the_best_answer?
          answer = question.answers.find_by(best: true)
          answer.update(best: false)
        end
        update(best: true)
      end
    end
  end
end
