require_relative '../features_helper'

feature 'User can Logout', %q{authenticated user can logout} do
  include_context 'users'

  scenario 'authenticated user can logout' do
    sign_in(user)
    expect(page).to have_content 'Выйти'
    click_on 'Выйти'

    expect(page).to have_content 'Выход из системы выполнен.'
    visit new_user_session_path

    expect(page).to have_field 'user[email]'
  end
end
