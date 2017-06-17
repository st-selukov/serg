require_relative '../features_helper'

feature 'Authenticated user can vote for the answer he likes' do
  given(:user) { create(:user, reputation: 25) }
  given(:user2) { create(:user, reputation: 25) }
  given!(:question) { create(:question, user: user2) }
  given!(:answer) { create(:answer, question: question, user: user2) }

  scenario 'user try votes_specs for the answer for the first time', js: true do
    sign_in(user)
    visit question_path(question)
    find('.vote-up-answer-link').click

    within "#answer-#{answer.id}-count-votes_specs" do
      expect(page).to have_content '1'
    end
  end
end