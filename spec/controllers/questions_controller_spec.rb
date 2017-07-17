require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  include_context 'controllers'
  let(:question) { create(:question, user_id: user.id) }
  let(:parent) { create(:question, user_id: user2.id) }

  describe 'GET #index' do

    let(:questions) { create_list(:question, 2, user_id: user.id) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    let(:answers) { create_list(:answer, 2, question_id: question.id, user_id: user.id) }

    before { get :show, params: { id: question,  user_id: user.id } }

    it 'set variable @question to requested question' do
      expect(assigns(:question)).to eq question
    end

    it 'populate attachment answers for questions' do
      expect(question.answers).to match_array(answers)
    end

    it 'build new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'render show templates' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns @question to new question' do
      expect(assigns(:question)).to be_a_new Question
    end

    it 'build new attachment for answer' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'render view templates -new-' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'create question with valid attributes' do

      it 'try save new question in database' do
        expect { post :create, params: { question: attributes_for(:question) } }
          .to change(Question, :count).by(1)
      end

      it 'redirect to question#show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(question.id - 1)
      end

      it 'create question for user ' do
        expect { post :create, params: { question: attributes_for(:question) } }
            .to change(@user.questions, :count).by(1)
      end
    end

    context 'create question with invalid attributes' do

      it 'try save new question, but not saving' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }
          .to_not change(Question, :count)
      end

      it 're render new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'if user owner question' do
      before { question.update(user: @user) }

      it 'destroy @question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirect to index templates' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'if user not owner question' do

      before { question.user = user }

      it 'not destroy question, if user is not the owner question' do
        expect { delete :destroy, params: { id: question } }.
            to_not change(Question, :count)
      end
    end
  end

  it_behaves_like 'ControllerVoted'
end
