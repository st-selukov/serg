require 'rails_helper'

RSpec.describe QuestionPolicy do

  subject { QuestionPolicy.new(user, question) }

  context 'for a  owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:question) { create(:question, user: user) }

    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'for a admin user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now, admin: true) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:question) { create(:question, user: user2) }

    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'not owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:question) { create(:question, user: user2) }

    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end
end
