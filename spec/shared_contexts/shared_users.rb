shared_context 'users', users: true do
  let(:user) { create(:user, reputation: 25) }
  let(:user2) { create(:user, reputation: 25) }
end