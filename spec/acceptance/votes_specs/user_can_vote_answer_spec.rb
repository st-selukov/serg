require_relative '../features_helper'

feature 'Authenticated user can vote for the answer he likes' do
  include_context 'users'
  given(:question) { create(:question, user: user2) }
  given(:parent) { create(:answer, question: question, user: user2) }

  it_behaves_like 'UserVoted'
end
