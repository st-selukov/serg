require "rails_helper"

describe DailyMailer do
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }


  describe 'daily_digest' do

    let(:email){ DailyMailer.daily_digest(user).deliver_now }

    it 'should send mail to user' do
      expect(email.to.first).to eq user.email
    end

    it 'should mail contains question' do
      expect(email.body).to have_content question.title
    end
  end
end
