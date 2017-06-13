require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, user_id: user.id, question_id: question.id) }
  let(:answer2) { create(:answer, user_id: user.id, question_id: question.id) }

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

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

  describe 'check attacments' do
    it 'return true if answer not have attachment' do
      expect(answer.not_have_attachment(answer: ['file'])).to be true
    end
  end
end
