class User < ApplicationRecord
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
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
    return authorization.user if authorization

    return if auth.info.blank?
    email = auth.info[:email]
    user = User.where(email: email).first

    if user
      user.create_authorization(auth)
      user.skip_confirmation!
    else
      password = Devise.friendly_token[0, 20]
      user = User.new(email: email, password: password, password_confirmation: password)
      return nil unless user.save
      user.update(confirmed_at: nil)
      user.skip_confirmation! if auth.provider == 'facebook'
      user.create_authorization(auth)
    end

    user
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
