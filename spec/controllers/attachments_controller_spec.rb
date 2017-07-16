require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  include_context 'controllers'
  let!(:question) { create(:question, user_id: user.id) }
  let!(:attachment) { create(:attachment, attachable: question) }

  describe 'DELETE #destroy' do
    sign_in_user

    context 'user owner attachment' do

      before do
        question.update(user: @user)
      end

      it 'delete attachment' do
        expect { delete :destroy, params: { id: attachment, format: :js } }.to change(Attachment, :count).by(-1)
      end
    end

    context 'user not owner attachment' do

      it 'delete attachment' do
        expect { delete :destroy, params: { id: attachment, format: :js } }.
            to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
