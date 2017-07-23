require 'rails_helper'

describe 'Question API' do

  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }

  describe 'GET /index' do

    let!(:questions) { create_list(:question, 2, user: user) }
    let!(:question) { questions.first }
    let!(:answer) { create(:answer, question: question, user: user) }


    def request(options = {})
      get '/api/v1/questions', params: { format: :json }.merge(options)
    end

    it_behaves_like 'AuthorizationApi'

    before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

    context 'authorized' do

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path("questions")
      end

      %w(title body).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).
              at_path("questions/0/#{attr}")
        end
      end
    end

    context 'answers' do

      it 'included in question object' do
        expect(response.body).to have_json_size(1).at_path("questions/1/answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).
              at_path("questions/1/answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET /show' do

    let(:question) { create(:question, user: user) }
    let!(:comments) { create_list(:comment, 2, commentable: question, user: user) }
    let!(:attachments) { create_list(:attachment, 2, attachable: question) }

    def request(options = {})
      get api_v1_question_path(question), params: { format: :json }.merge(options)
    end

    it_behaves_like 'AuthorizationApi'

    before { get api_v1_question_path(question), params: { format: :json, access_token: access_token.token } }

    context 'authorized' do

      it 'returns status 200 ' do
        expect(response).to be_success
      end

      it 'contains question in response' do
        expect(response.body).to have_json_size(1)
      end

      %w(title body ).each do |attr|
        it "question contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).
              at_path("question/#{attr}")
        end
      end

      it 'contains comments in question' do
        expect(response.body).to have_json_size(2).at_path('question/comments')
      end

      %w(id body created_at updated_at).each do |attr|
        it "comment contain #{attr}" do
          expect(response.body).to be_json_eql(comments.first.send(attr.to_sym).to_json).
              at_path("question/comments/0/#{attr}")
        end
      end

      it 'question contains attachments' do
        expect(response.body).to have_json_size(2).at_path('question/attachments')
      end

      it 'attachment have file url' do
        expect(response.body).to be_json_eql(attachments.last.file.url.to_json).
            at_path('question/attachments/0/url')
      end
    end
  end

  describe 'POST /create' do

    context 'valid attributes' do

      it 'created and saved in db' do
        expect { post api_v1_questions_path, params: { format: :json, access_token: access_token.token,
                      question: attributes_for(:question) } }.to change(Question, :count).by(1)

      end

      it 'return status created(201)' do
        post api_v1_questions_path, params: { format: :json, access_token: access_token.token,
             question: attributes_for(:question) }
        expect(response).to have_http_status :created
      end
    end

    context 'invalid attributes' do
      it ' not save on db' do
        expect { post api_v1_questions_path, params: { format: :json, access_token: access_token.token,
                      question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 'return status 422' do
        post api_v1_questions_path, params: { format: :json, access_token: access_token.token,
             question: attributes_for(:invalid_question) }
        expect(response.status).to eq 422
      end
    end
  end
end