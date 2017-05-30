module AcceptanceHelper

  def fill_password
    fill_in 'user[password]', with: 12345678
    fill_in 'user[password_confirmation]', with: 12345678
  end

  def sign_up
    visit root_path
    click_on 'Регистрация'

    expect(page).to have_button 'Регистрация'
    expect(current_path).to eq(new_user_registration_path)
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Войти'
  end
end
