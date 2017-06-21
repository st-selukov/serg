module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_parent, only: [:vote_up, :vote_down, :destroy_vote]
    before_action :check_before_voting, only: [:vote_up, :vote_down, :destroy_vote]
    before_action :check_user_before_voiting, only: [:vote_up, :vote_down]
  end

  def vote_up
    @parent.vote_up(current_user)
    publish_vote
  end

  def vote_down
    @parent.vote_down(current_user)
    publish_vote
  end

  def destroy_vote
    @parent.destroy_vote(current_user)
    publish_vote
  end

  private

  def publish_vote
    @parent.reload
    render json: [@parent, @parent.class.name.downcase], status: :ok
  end

  def check_before_voting
    unless user_signed_in? && current_user.have_reputation_for_voting?
      render json: [@parent, @parent.class.name.downcase,
                    'У вас не хватает репутации для этого'],
             status: :forbidden
    end
  end

  def check_user_before_voiting
    if current_user.votable_owner?(@parent)
      render json: [@parent, @parent.class.name.downcase,
                    'Нельзя голосовать за себя'],
             status: :forbidden
    elsif current_user.voted?(@parent)
      render json: [@parent, @parent.class.name.downcase,
                    'Вы уже голосовали'],
             status: :forbidden
    end
  end
end
