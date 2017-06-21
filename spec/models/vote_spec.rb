require 'rails_helper'
include Constants

RSpec.describe Vote, type: :model do
  include_context 'users'
  let(:user3){create(:user)}
  let(:question) { create(:question, user: user) }
  let!(:vote) { create(:vote, votable: question, user: user2, vote_value: 1) }

  it { should belong_to :votable }

  it { should validate_presence_of :user_id }

  it { should validate_presence_of :votable_id }

  it { should validate_presence_of :votable_type }

  it { should validate_presence_of :vote_value }

  it 'update votes sum in votable' do
    Vote.create(votable:question, user: user3, vote_value: 1)

    expect(question.votes_sum).to eq 2
  end

  describe 'change votable user reputation on vote' do

  end
end
