shared_examples_for 'ControllerVoted' do

  describe 'PUT #vote_up' do
    sign_in_user

    before :each do
      @user.update!(reputation: 25)
    end

    it 'does  votes sum increment' do

      put :vote_up, params: { id: parent.id }, format: :json
      parent.reload

      expect(parent.votes_sum).to eq 1
    end

    it 'it change parent user reputation' do
      put :vote_up, params: { id: parent.id }, format: :json
      parent.user.reload

      expect(parent.user.reputation).to eq 30
    end

    it 'it change voted user reputation' do
      put :vote_up, params: { id: parent.id }, format: :json
      @user.reload

      expect(@user.reputation).to eq 27
    end
  end

  describe 'PUT #vote_down' do
    sign_in_user

    before :each do
      @user.update!(reputation: 25)
    end

    it 'does  votes sum decrement' do
      put :vote_down, params: { id: parent.id }, format: :json
      parent.reload

      expect(parent.votes_sum).to eq(-1)
    end

    it 'it change parent user reputation' do
      put :vote_down, params: { id: parent.id }, format: :json
      parent.user.reload

      expect(parent.user.reputation).to eq 23
    end
  end

  describe 'DELETE #destroy_vote' do
    sign_in_user

    before do
      parent.votes.create(user: @user, votable: parent)
    end

    it 'does destroy vote and votes sum decrement' do
      delete :destroy_vote, params: { id: parent.id }, format: :json
      parent.reload

      expect(parent.votes_sum).to eq(0)
    end
  end
end
