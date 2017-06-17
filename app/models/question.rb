class Question < ApplicationRecord
  include Attachable
  include Votable

  default_scope { order ('created_at DESC') }

  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true
  validates :title, length: { in: 5..140 }

  def has_the_best_answer?
    answers.exists?(best: true) ? true : false
  end
end
