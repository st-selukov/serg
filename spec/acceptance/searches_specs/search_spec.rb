require_relative '../acceptance_helper'

feature 'searching with sphinx' do
  include_context 'users'
  given!(:question) { create(:question, title: 'question', user: user) }
  given!(:answer) { create(:answer, body: 'answer', question: question, user: user) }
  given!(:comment) { create(:comment, body: 'comment', commentable: question, user: user) }

  scenario 'User search questions' do

    ThinkingSphinx::Test.start do
      visit root_path

      fill_in 'search[query]', with: 'question'
      click_on 'Поиск'

      expect(page).to have_content question.title
    end
  end

  scenario 'User search answer' do

    ThinkingSphinx::Test.start do
      visit root_path

      fill_in 'search[query]', with: 'answer'
      click_on 'Поиск'

      expect(page).to have_content answer.body
    end
  end

  scenario 'User search comment' do

    ThinkingSphinx::Test.start do
      visit root_path

      fill_in 'search[query]', with: 'comment'
      click_on 'Поиск'

      expect(page).to have_content comment.body
    end
  end
end