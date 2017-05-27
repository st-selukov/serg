module AcceptanceHelper

  def fill_password
    fill_in 'Password', with: 12345678
    fill_in 'Password confirmation', with: 12345678
  end

  def sign_up
    visit root_path
    click_on 'Регистрация'

    expect(page).to have_button 'Sign up'
    expect(current_path).to eq(new_user_registration_path)
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end
