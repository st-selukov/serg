require 'rails_helper'

RSpec.describe AttachmentPolicy do

  subject { AttachmentPolicy.new(user, attachment) }

  context 'for a  owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:question) { create(:question, user: user) }
    let(:attachment) { create(:attachment, attachable: question) }

    it { should permit(:destroy) }
  end

  context 'for a admin user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now, admin: true) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:question) { create(:question, user: user2) }
    let(:attachment) { create(:attachment, attachable: question) }

    it { should permit(:destroy) }
  end

  context 'not owner user' do
    let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
    let(:question) { create(:question, user: user2) }
    let(:attachment) { create(:attachment, attachable: question) }

    it { should_not permit(:destroy) }
  end
end
