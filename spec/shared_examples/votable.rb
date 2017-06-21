shared_examples_for 'Votable' do

  it { should have_many(:votes).dependent(:destroy) }

  describe 'votable voted' do
    it 'create new vote with value 1' do
      parent.vote_up(user2)
      parent.reload

      expect(parent.votes_sum).to eq(1)
    end

    it 'update votable owner reputation' do
      parent.user.update(reputation: 25)
      parent.vote_up(user2)
      parent.reload

      expect(parent.user.reputation).to eq(30)
    end

    it 'update voter user reputation' do
      user2.update(reputation: 25)
      parent.vote_up(user2)
      parent.reload

      expect(user2.reputation).to eq(26)
    end

    it 'create new vote with value -1' do
      parent.vote_down(user2)
      parent.reload
      expect(parent.votes_sum).to eq(-1)
    end

    it 'update votable owner reputation for vote_up' do
      parent.user.update(reputation: 25)
      parent.vote_down(user2)
      parent.reload

      expect(parent.user.reputation).to eq(23)
    end

  end

  describe 'destroy vote' do
    let!(:vote) { create(:vote, votable: parent, user: user2, vote_value: 1) }
    before { parent.update(votes_sum: 1) }

    it 'delete vote' do
      parent.destroy_vote(user2)
      parent.reload

      expect(parent.votes_sum).to eq 0
    end
  end
end
