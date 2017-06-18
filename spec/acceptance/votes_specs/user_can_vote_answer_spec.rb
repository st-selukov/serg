require_relative '../features_helper'

feature 'Authenticated user can vote for the answer he likes' do
  include_context 'users'
  given!(:question) { create(:question, user: user2) }
  given!(:answer) { create(:answer, question: question, user: user2) }

  context 'with authenticated user' do
    scenario 'user tries to vote for the answer for the first time', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-up-answer-link').click

      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '1'
    end

    scenario 'user tries again to vote answer', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-up-answer-link').click

      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '1'
      find('.vote-up-answer-link').click
      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '1'
    end

    scenario 'user tries delete his vote for answer', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-up-answer-link').click

      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '1'
      find('.vote-reset-answer-link').click
      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '0'
    end

    scenario 'user tries to vote against for the answer for the first time', js: true do
      sign_in(user)
      visit question_path(question)
      find('.vote-down-answer-link').click

      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '-1'
    end
  end

  context 'with unauthenticated user' do
    scenario 'host tries to vote for the answer ', js: true do
      visit question_path(question)
      find('.vote-up-answer-link').click

      expect(page).to have_selector "#answer-#{answer.id}-count-votes", text: '0'
    end
  end
end
