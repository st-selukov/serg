require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers) }
  it { should have_many(:questions) }

  describe 'conformity object user and current_user' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, user_id: user.id) }

    it 'should to be true' do
      expect(user).to be_author_of(question)
    end

    it 'should to be false' do
      expect(user2).to_not be_author_of(question)
    end
  end
end
