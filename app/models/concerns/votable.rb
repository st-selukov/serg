module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(voter)
    votes.create(user: voter, vote_value: 1) unless voter.voted? self
  end

  def vote_down(voter)
    votes.create(user: voter, vote_value: -1) unless voter.voted? self
  end

  def destroy_vote(voter)
    vote = votes.find_by_user_id(voter)
    vote.destroy
  end

  def update_votes
    update(votes_sum: votes.sum(:vote_value))
  end

end
