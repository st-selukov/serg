class Vote < ApplicationRecord
  include Constants
  belongs_to :user
  belongs_to :votable, polymorphic: true, optional: true

  validates :user_id, :votable_id, :votable_type, :vote_value, presence: true

  after_destroy :change_vote_sum
  after_save :change_vote_sum, :up_owner_reputation, :change_votable_user_reputation

  def change_vote_sum
    votable.update_votes
  end

  def change_votable_user_reputation
    if vote_value == 1
      votable.user.change_reputation(YOUR_VOTABLE_IS_VOTED_UP)
    elsif vote_value == -1
      votable.user.change_reputation(YOUR_VOTABLE_IS_VOTED_DOWN)
    end
  end

  def up_owner_reputation
    user.change_reputation(YOU_VOTED_UP_AN_VOTABLE)
  end
end
