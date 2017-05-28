require_relative '../features_helper'

feature 'Create Question', %q{
  To get an answer, an authenticated user can ask a question
} do

  given!(:user) {create(:user)}
  given!(:questions) {create_list(:question, 2, user: user)}

  scenario 'authenticated user can see questions list' do
    visit root_path
    sign_in(user)

    expect(page).to have_content 'MyText', count: 2
  end

  scenario 'authenticated user try created question' do
    visit questions_path
    sign_in(user)

    within('.ask-question') do
      click_on 'Задать вопрос'
    end

    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[body]', with: 'Test Text'
    click_on 'Разместить вопрос на сайте'

    expect(page).to have_content 'Test Text'
  end

  scenario 'authenticated user try created question with invalid question' do
    visit questions_path
    sign_in(user)

    within('.ask-question') do
      click_on 'Задать вопрос'
    end

    fill_in 'question[title]', with: ''
    fill_in 'question[body]', with: ''
    click_on 'Разместить вопрос на сайте'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Title is too short (minimum is 5 characters)"
    expect(page).to have_content "Body can't be blank"
  end

  scenario 'non authenticated user try created question' do
    visit questions_path

    within('.ask-question') do
      click_on 'Задать вопрос'
    end

    expect(current_path).to eq new_user_session_path
  end
end