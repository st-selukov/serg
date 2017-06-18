shared_examples_for 'ControllerVoted' do

  describe 'PUT #vote_up' do
    sign_in_user

    it 'does  votes sum increment' do
      put :vote_up, params: { id: parent.id, format: :json }
      parent.reload

      expect(parent.votes_sum).to eq 1
    end

    it 'does response have parent object in json format' do
      put :vote_up, params: { id: parent.id, format: :json }
      parent.reload

      expect(response.body).to include parent.to_json
    end
  end

end