require_relative '../features_helper'

feature 'Guest can register', %q{To use the site the guest can register} do

  scenario 'quest enters valid data' do
    sign_up

    fill_in 'user[email]', with: 'testuser@test.com'
    fill_password
    click_on 'Регистрация'

    open_email 'testuser@test.com'
    current_email.click_link 'Confirm my account'
    clear_emails

    fill_in 'user[email]', with: 'testuser@test.com'
    fill_in 'user[password]', with: '12345678'
    click_on 'Войти'

    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Вход в систему выполнен.'
  end

  scenario 'quest enters blank password' do
    sign_up
    fill_in 'user[email]', with: 'testuser@test.com'
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_on 'Регистрация'

    expect(page).to have_content 'Необходимо ввести пароль'
    expect(current_path).to eq user_registration_path
  end
end
