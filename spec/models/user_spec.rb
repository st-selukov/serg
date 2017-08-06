require 'rails_helper'
include Constants

RSpec.describe User, type: :model do
  include_context 'users'
  let(:question) { create(:question, user_id: user.id) }
  let(:question2) { create(:question, user_id: user.id) }
  let!(:vote) { create(:vote, user_id: user.id, votable: question, vote_value: 1) }

  it { should have_many(:answers) }
  it { should have_many(:questions) }
  it { should have_many(:authorizations) }

  describe 'conformity object user and current_user' do

    it 'does to be true' do
      expect(user).to be_author_of(question)
    end

    it 'does to be false' do
      expect(user2).to_not be_author_of(question)
    end
  end

  describe 'change user reputation' do

    it 'does increase reputation by value ' do
      user.update!(reputation: 5)
      user.change_reputation(YOUR_VOTABLE_IS_VOTED_UP)

      expect(user.reputation).to eq(10)
    end


    it 'does reduce reputation by value' do
      user.update!(reputation: -10)
      user.change_reputation(YOUR_VOTABLE_IS_VOTED_DOWN)

      expect(user.reputation).to eq(-12)
    end
  end

  describe 'check user vote for the votable' do

    it 'does to be true' do
      expect(user.voted?(question)).to be true
    end

    it 'does to be false' do
      expect(user.voted?(question2)).to be false
    end
  end

  describe 'find_for_oauth' do

    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                        info: { email: user.email }) }

    context 'user already has authentication' do
      it 'return the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do

      context 'user alredy exist' do

        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                            info: { email: user.email }) }

        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorizations for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorizations with provider and uid ' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
    end

    context 'user does not exist ' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                          info: { email: 'new@user.com' }) }

      it 'creates new user' do
        expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(User.find_for_oauth(auth)).to be_a(User)
      end

      it 'fills user email' do
        user = User.find_for_oauth(auth)
        expect(user.email).to eq auth.info.email
      end

      it 'creates authorization for user' do
        user = User.find_for_oauth(auth)
        expect(user.authorizations).to_not be_empty
      end

      it 'creates authorization with provider and uid' do
        authorization = User.find_for_oauth(auth).authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end
  end

  describe 'send daily digest' do
    let(:users) { create_list(:user, 3) }

    it 'send daily mailer for all users' do
      users.each do |user|
        expect(DailyMailer).to receive(:daily_digest).with(user).and_call_original
      end
      User.send_daily_digest
    end
  end
end
