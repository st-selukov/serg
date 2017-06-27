class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, optional: true
  belongs_to :user

  validates :body, :user_id, :commentable_id, :commentable_type, presence: true
end
