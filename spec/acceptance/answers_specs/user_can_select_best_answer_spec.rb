require_relative '../features_helper'

feature 'User select best answer', %q{The user who asked the question can mark the best answer} do
  include_context 'users'
  given(:question) { create(:question, user: user) }

  context 'with one answer on page' do

    given!(:answer) { create(:answer, question: question, user: user, best: false) }

    scenario 'user marked best answer' do
      sign_in(user)
      visit question_path(question)
      click_on 'Лучший ответ'

      expect(page).to have_content 'Автор отметил ответ, как лучший'
    end
  end

  context 'with two answer on page' do

    given!(:answer1) { create(:answer, question: question, user: user, best: true) }

    given!(:answer2) { create(:answer, question: question, user: user, best: false) }

    scenario 'best answer is displayed first in answers list' do
      sign_in(user)
      visit question_path(question)

      within "#current_answer-#{answer1.id}" do
        expect(page).to have_content 'Автор отметил ответ, как лучший'
      end
      within "#current_answer-#{answer2.id}" do
        expect(page).to_not have_content 'Автор отметил ответ, как лучший'
      end

      within "#current_answer-#{answer2.id}" do
        click_on 'Лучший ответ'
      end

      within "#current_answer-#{answer1.id}" do
        expect(page).to_not have_content 'Автор отметил ответ, как лучший'
      end
      within "#current_answer-#{answer2.id}" do
        expect(page).to have_content 'Автор отметил ответ, как лучший'
      end
    end
  end
end
