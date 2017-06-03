require_relative '../features_helper'

feature 'Create Answer', %q{User  can create answers for questions} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'authenticated user try create answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in  'answer[body]', with: 'Test Answer'
    click_on 'Разместить ответ'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Test Answer'
  end

  scenario 'authenticated user try create answer with blank body', js: true do
    sign_in(user)
    visit question_path(question)

    expect(current_path).to eq question_path(question)

    fill_in 'answer[body]', with: ''
    click_on 'Разместить ответ'

    expect(page).to have_content 'Необходимо заполнить поле ответа'
  end

  scenario 'non authenticated user  can try create answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'answer[body]'
  end
end
