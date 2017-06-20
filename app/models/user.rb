class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author_of?(obj)
    id == obj.user_id
  end

  alias votable_owner? author_of?

  def change_reputation(val)
    update(reputation: reputation + val)
  end

  def voted?(votable)
    votes.exists?(votable: votable)
  end

  def have_reputation_for_voting?
    reputation >= 20
  end
end
