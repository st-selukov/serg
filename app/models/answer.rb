class Answer < ApplicationRecord

  default_scope { order 'created_at ASC' }

  belongs_to :question
  validates :body, presence: true
end
