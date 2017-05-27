class Answer < ApplicationRecord

  default_scope { order 'created_at ASC' }

  belongs_to :question
  belongs_to :user
  validates :body, presence: true
end
