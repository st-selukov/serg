class Question < ApplicationRecord

  default_scope { order 'created_at DESC' }

  has_many :answers, dependent: :destroy
  validates :title, :body, presence: true
  validates :title, length: { in: 5..140 }
end
