require_relative '../features_helper'

feature 'Question comments' do

  include_context 'users'

  given(:question) { create(:question, user: user) }
  given!(:comment) { create(:comment, user: user, commentable: question) }

  context 'with valid attributes' do
    scenario 'authenticated user can create comment', js: true do
      create_valid_question_comment(question)

      expect(page).to have_content 'Test Comment'
    end
  end

  context 'with invalid attributes' do
    scenario 'authenticated user can create comment with blank body', js: true do
      create_invalid_question_comment(question)

      expect(page).to have_content 'Не заполнен текст комментария'
    end
  end

  context 'multiplay session' do
    scenario 'comment add for another user', js: true do

      Capybara.using_session(user2) do
        sign_in(user2)
        visit question_path(question)
      end

      Capybara.using_session(user) do
        create_valid_question_comment(question)
      end

      Capybara.using_session(user2) do
        expect(page).to have_content 'Test Comment'
      end
    end
  end

  scenario 'delete comment', js: true do
    sign_in(user)
    visit question_path(question)
    find('.delete-comment').click

    expect(page).to_not have_content 'Test Comment'
  end
end