require_relative '../features_helper'

feature 'User Sign In', %q{User can signed site to use it} do

  given(:user) { create(:user) }

  scenario 'registered user try to signed' do
    sign_in(user)

    expect(page).to have_content 'Вход в систему выполнен.'
    expect(current_path).to eq root_path
  end

  scenario 'non registered user try to signed' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'wrong@test.com'
    fill_in 'user[password]', with: '12345678'
    click_on 'Войти'

    expect(current_path).to eq new_user_session_path
  end
end
