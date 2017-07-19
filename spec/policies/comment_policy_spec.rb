require 'rails_helper'

RSpec.describe CommentPolicy do

  subject { CommentPolicy.new(user, comment) }

  let(:question) { create(:question, user: user) }

  context 'for a  owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:comment) { create(:comment, commentable: question, user: user) }

    it { should permit(:destroy) }
  end

  context 'for a admin user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now, admin: true) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:comment) { create(:comment, commentable: question, user: user2) }

    it { should permit(:destroy) }
  end

  context 'not owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:comment) { create(:comment, commentable: question, user: user2) }

    it { should_not permit(:destroy) }
  end
end
