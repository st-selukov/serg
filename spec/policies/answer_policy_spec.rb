require 'rails_helper'

RSpec.describe AnswerPolicy do

  subject { AnswerPolicy.new(user, answer) }
  let(:question) { create(:question, user: user) }

  context 'for a  owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:answer) { create(:answer, question: question, user: user) }

    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'for a admin user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now, admin: true) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:answer) { create(:answer, question: question, user: user2) }

    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'not owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:answer) { create(:answer, question: question, user: user2) }

    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end

  context 'best answer' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:answer) { create(:answer, question: question, user: user2) }

    it { should permit(:best_answer) }
  end
end
