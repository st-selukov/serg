shared_examples_for 'ControllerVoted' do

  describe 'PUT #vote_up' do
    sign_in_user

    before { @user.update!(reputation: 25) }

    it 'does  votes sum increment' do

      put :vote_up, params: { id: parent.id }, format: :json
      parent.reload

      expect(parent.votes_sum).to eq 1
    end
  end

  describe 'PUT #vote_down' do
    sign_in_user

    before { @user.update!(reputation: 25) }

    it 'does  votes sum decrement' do
      put :vote_down, params: { id: parent.id }, format: :json
      parent.reload

      expect(parent.votes_sum).to eq(-1)
    end
  end

  describe 'DELETE #destroy_vote' do
    sign_in_user

    before do
      @user.update!(reputation: 25)
      parent.votes.create(user: @user, votable: parent, vote_value: 1)
    end

    it 'does destroy vote and votes sum decrement' do
      delete :destroy_vote, params: { id: parent.id }, format: :json
      parent.reload

      expect(parent.votes_sum).to eq(0)
    end
  end
end
