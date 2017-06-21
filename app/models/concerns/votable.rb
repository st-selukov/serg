module Votable
  extend ActiveSupport::Concern
  include Constants

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(voter)
    votes.create(user: voter, vote_value: 1) unless voter.voted? self
    change_reputation_on_vote(YOUR_VOTABLE_IS_VOTED_UP,
                              YOU_VOTED_VOTABLE,voter)
  end

  def vote_down(voter)
    votes.create(user: voter, vote_value: -1) unless voter.voted? self
    change_reputation_on_vote(YOUR_VOTABLE_IS_VOTED_DOWN,
                              YOU_VOTED_VOTABLE, voter)
  end

  def destroy_vote(voter)
    vote = votes.find_by_user_id(voter)
    vote.destroy
  end

  def update_votes
    update(votes_sum: votes.sum(:vote_value))
  end

  def change_reputation_on_vote(vote_value1, vote_value2, voter)
    user.change_reputation(vote_value1)
    voter.change_reputation(vote_value2)
  end
end
