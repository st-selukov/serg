require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do

    context ' create answer with valid attributes' do

      it 'create answer for question and saving in database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }
          .to change(question.answers, :count).by(1)
      end
    end

    context 'create answer with invalid attributes' do

      it 'try save new question, but not save' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer) } }
          .to_not change(Answer, :count)
      end
    end

    it 'redirect to questions#show view' do
      post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
      expect(response).to redirect_to question_path(question)
    end
  end
end
