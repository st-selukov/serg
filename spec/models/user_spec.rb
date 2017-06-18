require 'rails_helper'
include Constants

RSpec.describe User, type: :model do
  include_context 'users'
  let(:question) { create(:question, user_id: user.id) }
  let(:question2) { create(:question, user_id: user.id) }
  let!(:vote) { create(:vote, user_id: user.id, votable: question) }

  it { should have_many(:answers) }
  it { should have_many(:questions) }

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
end
