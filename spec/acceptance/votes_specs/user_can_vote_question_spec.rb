require_relative '../features_helper'

feature 'Authenticated user can vote for the question he likes' do
  include_context 'users'
  given(:parent) { create(:question, user: user2) }

  it_behaves_like 'UserVoted'
end
