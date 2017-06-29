require_relative '../features_helper'

feature 'Create Question', %q{
  To get an answer, an authenticated user can ask a question
} do
  include_context 'users'
  given!(:questions) {create_list(:question, 2, user: user)}

  scenario 'authenticated user can see questions list' do
    visit root_path
    sign_in(user)

    expect(page).to have_content 'MyText', count: 2
  end

  scenario 'authenticated user try created question' do
    sign_in(user)
    create_valid_question

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

    expect(page).to have_content 'Название вопроса обязательно для заполнения'
    expect(page).to have_content 'Название вопроса  должно быть не менее 5 символов и не более 140 символов'
    expect(page).to have_content 'Нет описания вопроса'
  end

  scenario 'non authenticated user try created question' do
    visit questions_path

    within('.ask-question') do
      click_on 'Задать вопрос'
    end

    expect(current_path).to eq new_user_session_path
  end

  context 'multiple session' do
    scenario 'question appear on another user on create', js: true do
      Capybara.using_session(user2) do
        sign_in(user2)
        visit questions_path
      end

      Capybara.using_session(user) do
        sign_in(user)
        create_valid_question
      end

      Capybara.using_session(user2) do
        expect(page).to have_content 'Test Text'
      end
    end
  end
end
