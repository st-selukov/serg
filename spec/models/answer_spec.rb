require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, user_id: user.id, question_id: question.id, best: false) }

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }

  describe 'set answer the best' do

    before { answer.set_the_best_answer }

    it 'does make answer best' do
      expect(answer).to have_attributes(best: true)
    end

  end
end
