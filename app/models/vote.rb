class Vote < ApplicationRecord

  belongs_to :user
  belongs_to :votable, polymorphic: true, optional: true

  validates :user_id, :votable_id, :votable_type, presence: true
end
