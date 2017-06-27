require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id, best: false) }
  let!(:comment) { create(:comment, commentable: question, user: user) }
  let!(:comment2) { create(:comment, commentable: answer, user: user) }

  describe 'POST #create' do
    sign_in_user

    context 'comment for question' do

      it 'does  create new comment for question ' do
        expect { post :create, params: { question_id: question.id,
                                       comment: attributes_for(:comment).merge(user: user), format: :js } }.
            to change(Comment, :count).by(1)
      end
    end

    context 'comment for answer' do

      it 'does create new comment for answer ' do
        expect { post :create, params: { answer_id: answer.id,
                                       comment: attributes_for(:comment).merge(user: user), format: :js } }.
            to change(Comment, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'comment for question' do

      before { comment.update!(user: @user) }

      it 'does destroy comment for question ' do
        expect { delete :destroy, params: { question_id: question.id, id: comment.id,
                        format: :js } }.to change(Comment, :count).by(-1)
      end
    end

    context 'comment for answer' do

      before { comment2.update!(user: @user) }

      it 'should destroy comment for answer ' do

        expect { delete :destroy, params: { answer_id: answer.id, id: comment2.id,
                        format: :js } }.to change(Comment, :count).by(-1)
      end
    end
  end
end
