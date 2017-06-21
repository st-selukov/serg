class Vote < ApplicationRecord
  include Constants
  belongs_to :user
  belongs_to :votable, polymorphic: true, optional: true

  validates :user_id, :votable_id, :votable_type, :vote_value, presence: true

  after_destroy :change_vote_sum
  after_save :change_vote_sum

  def change_vote_sum
    votable.update_votes if votable
  end
end
