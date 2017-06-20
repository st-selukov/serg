require 'rails_helper'

RSpec.describe Vote, type: :model do
  include_context 'users'
  let(:question) { create(:question, user: user) }
  let(:vote) { create(:vote, votable: question, user: user2, vote_value: 1) }

  it { should belong_to :votable }

  it { should validate_presence_of :user_id }

  it { should validate_presence_of :votable_id }

  it { should validate_presence_of :votable_type }

  it { should validate_presence_of :vote_value }

  describe 'check voted user reputation' do
    it 'raise error' do
      user2.update(reputation: 10)
      vote.check_owner_repuation

      expect(vote.check_owner_repuation).to raise_error

    end
  end
end
