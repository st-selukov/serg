require_relative '../features_helper'

feature 'Update Question', %q{user can edit and update his question} do
  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'authenticated user try edit, and update his question' do
    sign_in(user)
    click_on 'MyString'
    click_on 'Редактировать вопрос'
    fill_in 'question[body]', with: 'New Text'
    click_on 'Обновить вопрос'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'New Text'
    expect(page).to_not have_content 'MyText'
  end

  scenario 'authenticated user try edit, and update not his question' do
    sign_in(user2)
    click_on 'MyString'

    expect(page).to_not have_content 'Редактировать вопрос'
  end


  scenario 'non authenticated user try edit, and update question' do
    visit questions_path
    click_on 'MyString'

    expect(page).to_not have_content 'Редактировать вопрос'
  end
end