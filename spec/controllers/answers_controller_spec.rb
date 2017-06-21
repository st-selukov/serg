require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  include_context 'controllers'
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }
  let!(:answer2) { create(:answer, question_id: question.id, user_id: user.id) }

  describe 'POST #create' do
    sign_in_user

    context ' create answer with valid attributes' do

      it 'create answer for question and saving in database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js  } }
            .to change(question.answers, :count).by(1)
      end

      it 'create answer for user ' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js  } }
            .to change(@user.answers, :count).by(1)
      end
    end

    context 'create answer with invalid attributes' do

      it 'try save new question, but not save' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer), format: :js  } }
            .to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'answer belongs to the user' do
      before { answer.update!(user: @user) }

      it 'delete answer' do
        expect { delete :destroy, params: { id: answer, format: :js } }.to change(Answer, :count).by(-1)
      end
    end

    context 'Answer not belongs to the user' do

      before { answer.user = user }

      it 'not destroy answer, If user is not the owner answer', js: true do
        expect { delete :destroy, params: { id: answer, format: :js } }.to_not change(Answer, :count)
      end

      it 'not destroy answer, If user is not the owner answer', js: true do
        delete :destroy, params: { id: answer, format: :js }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'POST #best_answer' do
    sign_in_user

    context 'with best equal false' do
      before do
        question.update!(user: @user)
        answer.update!(best: false)
      end

      it 'sets answer best on true' do
        post :best_answer, params: { id: answer }
        answer.reload
        expect(answer.best).to be true
      end

      it 'redirect answer.question view' do
        post :best_answer, params: { id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'with best equal true' do
      before do
        question.update!(user: @user)
        answer.update!(best: true)
      end

      it 'sets answer best on true' do
        post :best_answer, params: { id: answer2 }
        answer.reload
        expect(answer.best).to be false
      end
    end
  end

  let(:parent) { create(:answer, question: question, user: user2) }
  it_behaves_like 'ControllerVoted'
end
