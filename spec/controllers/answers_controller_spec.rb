require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

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
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end
    end

    context 'Answer not belongs to the user' do

      before { answer.user = user }

      it 'not destroy answer, If user is not the owner answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end
    end
  end
end
