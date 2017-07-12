shared_context 'users', users: true do
  let(:user) { create(:user, reputation: 25, confirmed_at: Time.now) }
  let(:user2) { create(:user, reputation: 25, confirmed_at: Time.now) }
end