require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, user_id: user.id, question_id: question.id) }
  let(:answer2) { create(:answer, user_id: user.id, question_id: question.id) }

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }

  describe 'set answer the best' do

    before do
      answer2.update!(best: true)
      answer.set_best
    end

    it 'does make answer best' do
      expect(answer).to have_attributes(best: true)
    end

    it 'does another answer not best' do
      answer2.reload

      expect(answer2).to have_attributes(best: false)
    end
  end
end
