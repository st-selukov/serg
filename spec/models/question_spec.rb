require 'rails_helper'

RSpec.describe Question, type: :model do
  include_context 'users'
  let(:question) { create(:question, user_id: user.id) }
  let(:question2) { create(:question, user_id: user.id) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_length_of(:title).is_at_least(5).is_at_most(140) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to :user }

  describe 'question has best answer' do
    let!(:answer) { create(:answer, user_id: user.id, question_id: question.id, best: true) }
    let!(:answer2) { create(:answer, user_id: user.id, question_id: question2.id, best: false) }

    it 'does to be true' do
      expect(question).to be_has_the_best_answer
    end

    it 'does to be false' do
      expect(question2).to_not be_has_the_best_answer
    end
  end

  let(:parent) { question }
  it_behaves_like 'Votable'
  it_behaves_like 'Attachable'
end
