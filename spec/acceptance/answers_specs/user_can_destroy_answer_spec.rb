require_relative '../features_helper'

feature 'Destroy Answer', %q{User can destroy his answer} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'authenticated user try destroy his answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Удалить ответ'

    expect(page).to_not have_content answer.body
  end

  scenario 'authenticated user try destroy not your answer', js: true do
    sign_in(user2)
    visit question_path(question)

    expect(page).to_not have_content 'Удалить ответ'
  end

  scenario 'non authenticated user try destroy answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Удалить ответ'
  end
end
