class Question < ApplicationRecord
  include Attachable
  include Votable
  include Commentable

  default_scope { order ('created_at DESC') }

  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true
  validates :title, length: { in: 5..140 }

  after_save :up_owner_reputation

  def has_the_best_answer?
    answers.exists?(best: true) ? true : false
  end

  def up_owner_reputation
    user.change_reputation(YOU_PLACED_QUESTION_OR_ANSWER)
  end
end
