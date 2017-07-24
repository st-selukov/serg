require 'rails_helper'

describe 'Answers API' do

  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let(:question) { create(:question, user: user) }

  def request(options = {})
    get  api_v1_question_answers_path(question), params: { format: :json }.merge(options)
  end

  describe 'GET /index' do

    let!(:answers) { create_list(:answer, 2, question: question, user: user) }

    before { get api_v1_question_answers_path(question), params: { format: :json, access_token: access_token.token } }

    it_behaves_like 'AuthorizationApi'

    context 'authorized' do

      it 'returns status 200' do
        expect(response).to be_success
      end

      it 'contains answers' do
        expect(response.body).to have_json_size(2).at_path('answers')
      end

      %w(id body created_at updated_at).each do |attr|
        it "answers contains #{attr}" do
          expect(response.body).to be_json_eql(answers.first.send(attr.to_sym).to_json).
              at_path("answers/0/#{attr}")
        end
      end
    end

  end

  describe 'GET /show' do

    let!(:answer) { create(:answer, question: question, user: user) }
    let!(:comments) { create_list(:comment, 2, commentable: answer, user: user) }
    let!(:attachments) { create_list(:attachment, 2, attachable: answer) }

    before { get api_v1_answer_path(answer.id), params: { format: :json, access_token: access_token.token } }

    it_behaves_like 'AuthorizationApi'

    context 'authorized' do

      it 'returns status 200' do
        expect(response).to be_success
      end

      it 'contains answer' do
        expect(response.body).to have_json_size(1)
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).
              at_path("answer/#{attr}")
        end
      end

      it 'contains comments in answer' do
        expect(response.body).to have_json_size(2).at_path('answer/comments')
      end

      %w(id body created_at updated_at).each do |attr|
        it "comment contains #{attr}" do
          expect(response.body).to be_json_eql(comments.first.send(attr.to_sym).to_json).
              at_path("answer/comments/0/#{attr}")
        end
      end

      it 'contains attachments in answer' do
        expect(response.body).to have_json_size(2).at_path('answer/attachments')
      end

      it 'attachment have file url' do
        expect(response.body).to be_json_eql(attachments.last.file.url.to_json).
            at_path('answer/attachments/0/url')
      end
    end
  end

  describe 'POST /create' do

    context 'valid attributes' do

      it 'created and saved in db' do
        expect { post api_v1_question_answers_path(question),  params: { answer: attributes_for(:answer),
                      format: :json, access_token: access_token.token } }.to change(Answer, :count).by(1)

      end

      it 'return status created(201)' do
        post api_v1_question_answers_path(question), params: { answer: attributes_for(:answer),
             format: :json, access_token: access_token.token }
        expect(response).to have_http_status :created
      end
    end

    context 'invalid attributes' do

      it ' not save on db' do
        expect { post api_v1_question_answers_path(question), params: {answer: attributes_for(:invalid_answer),
                      format: :json, access_token: access_token.token } }.to_not change(Answer, :count)
      end

      it 'return status 422' do
        post  api_v1_question_answers_path(question), params: { answer: attributes_for(:invalid_answer),
             format: :json, access_token: access_token.token }
        expect(response.status).to eq 422
      end
    end
  end
end