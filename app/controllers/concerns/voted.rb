module Voted
  extend ActiveSupport::Concern
  include Constants

  included do
    before_action :find_parent, only: [:vote_up, :vote_down, :destroy_vote]
    before_action :check_reputation, only: [:vote_up, :vote_down, :destroy_vote]
  end

  def vote_up
    if user_signed_in? && !current_user.votable_owner?(@parent)
      @parent.vote_up(current_user)
      @parent.user.change_reputation(YOUR_VOTABLE_IS_VOTED_UP)
      current_user.change_reputation(YOU_VOTED_UP_AN_VOTABLE)
      publish_vote
    end
  end

  def vote_down
    if user_signed_in? && !current_user.votable_owner?(@parent)
      @parent.vote_down(current_user)
      @parent.user.change_reputation(YOUR_VOTABLE_IS_VOTED_DOWN)
      publish_vote
    end
  end

  def destroy_vote
    if user_signed_in? && !current_user.votable_owner?(@parent)
      @parent.destroy_vote(current_user)
      publish_vote
    end
  end

  private

  def publish_vote
    render json: @parent, status: :ok
  end

  def check_reputation
    if user_signed_in? && !current_user.have_reputation_for_voting?
      render json: current_user.reputation, status: :unprocessable_entity
    end
  end
end