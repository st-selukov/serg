require_relative '../features_helper'

feature 'Authenticated user can vote for the question he likes' do
  include_context 'users'
  given!(:question) { create(:question, user: user2) }

  context 'with authenticated user' do
    scenario 'user tries to vote for the question for the first time', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-up-question-link').click

      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '1'
    end

    scenario 'user tries again to vote question', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-up-question-link').click

      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '1'
      find('.vote-up-question-link').click
      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '1'
    end

    scenario 'user tries delete his vote for question', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-up-question-link').click

      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '1'
      find('.vote-reset-question-link').click
      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '0'
    end

    scenario 'user tries to vote against for the question for the first time', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-down-question-link').click

      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '-1'
    end
  end

  context 'with unauthenticated user' do
    scenario 'host tries to vote for the question ', js: true do
      visit question_path(question)
      find('.vote-up-question-link').click

      expect(page).to have_selector "#question-#{question.id}-count-votes", text: '0'
    end
  end
end
