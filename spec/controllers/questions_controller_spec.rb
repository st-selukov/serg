require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { create(:question) }

  describe 'GET #index' do

    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    let(:answers) { create_list(:answer, 2, question_id: question.id) }

    before { get :show, params: { id: question } }

    it 'set variable @question to requested question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show template' do
      expect(response).to render_template :show
    end

    it 'populate attachment answers for questions' do
      expect(question.answers).to match_array(answers)
    end
  end

  describe 'GET #new' do

    before { get :new }

    it 'assigns @question to new question' do
      expect(assigns(:question)).to be_a_new Question
    end

    it 'render view template -new-' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    context ' create question with valid attributes' do

      it 'try save new question in database' do
        expect { post :create, params: { question: attributes_for(:question) } }
          .to change(Question, :count).by(1)
      end

      it 'redirect to questions#index view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to questions_path
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
end
