shared_examples_for 'Votable' do

  it { should have_many(:votes).dependent(:destroy) }

  describe 'votable voted' do
    it 'create new vote with value 1' do
      parent.vote_up(user2)
      expect(parent.votes_sum).to eq(1)
    end

    it 'create new vote with value -1' do
      parent.vote_down(user2)
      expect(parent.votes_sum).to eq(-1)
    end
  end

  describe 'destroy vote' do
    let!(:vote) { create(:vote, votable: parent, user: user2) }
    before { parent.update(votes_sum: 1) }

    it 'delete vote' do
      parent.destroy_vote(user2)
      expect(parent.votes_sum).to eq 0
    end
  end
end
