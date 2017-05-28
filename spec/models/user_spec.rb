require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers) }
  it { should have_many(:questions) }

  describe 'conformity object user and current_user' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, user_id: user.id) }
    let(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

    it 'should to be true' do
      expect(user.author_of?(question)).to be true
    end

    it 'should to be true' do
      expect(user.author_of?(answer)).to be true
    end

    it 'should to be false' do
      expect(user2.author_of?(question)).to  be false
    end

    it 'should to be false' do
      expect(user2.author_of?(answer)).to be false
    end
  end
end
