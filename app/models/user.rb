class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy
  has_many :authorizations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

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

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    authorization.user if authorization

    email = auth.info[:email] unless auth.info.blank?
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      # user.skip_confirmation! if auth.provider == 'facebook'
      # return nil unless user.save
      user.create_authorization(auth)
    end
    user
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
