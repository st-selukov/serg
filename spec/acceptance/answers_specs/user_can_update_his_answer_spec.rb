require_relative '../features_helper'

feature 'Update Answer', %q{user can edit and update his answer} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'authenticted user edit and update his answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Редактировать ответ'
    within '.current-answer-edit-form' do
      fill_in 'answer[body]', with: 'New Text'
      click_on 'Обновить ответ'
    end

    expect(page).to have_content 'New Text'
    expect(page).to_not have_content 'MyAnswers'
  end

  scenario 'authenticted user edit and update his answer with blank data', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Редактировать ответ'
    within '.current-answer-edit-form' do
      fill_in 'answer[body]', with: ''
      click_on 'Обновить ответ'
    end

    expect(page).to have_content 'Необходимо заполнить поле ответа'
  end

  scenario 'authenticated user try update not your answer' do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_content 'Редактировать ответ'
  end

  scenario 'non authenticated user try update answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Редактировать ответ'
  end

end
