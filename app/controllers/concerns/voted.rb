module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_parent, only: [:vote_up, :vote_down, :destroy_vote]
    before_action :check_before_voting, only: [:vote_up, :vote_down, :destroy_vote]
  end

  def vote_up
    unless current_user.votable_owner?(@parent)
      @parent.vote_up(current_user)
      publish_vote
    end
  end

  def vote_down
    unless current_user.votable_owner?(@parent)
      @parent.vote_down(current_user)
      publish_vote
    end
  end

  def destroy_vote
    unless current_user.votable_owner?(@parent)
      @parent.destroy_vote(current_user)
      publish_vote
    end
  end

  private

  def publish_vote
    @parent.reload
    render json: @parent, status: :ok
  end

  def check_before_voting
      user_signed_in? && current_user.have_reputation_for_voting?
  end
end
