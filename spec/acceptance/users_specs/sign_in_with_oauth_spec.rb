require_relative '../features_helper'

feature 'Sign in with oauth providers' do

  background { OmniAuth.config.test_mode = true }

  scenario 'sign in with  provider facebook, provider  given email' do
    mock_facebook
    visit new_user_session_path
    click_on 'Войти через Facebook'

    expect(page).to have_content 'Вход в систему выполнен с учётной записью из Facebook'
  end

  scenario 'sign in with  provider twitter,  provider does not give the email ' do
    mock_twitter
    visit new_user_session_path
    click_on 'Войти через Twitter'
    fill_in 'auth[info][email]', with: 'test1@test.com'
    click_on 'Отправить'

    open_email 'test1@test.com'
    current_email.click_link 'Confirm my account'
    clear_emails

    click_on 'Войти через Twitter'

    expect(page).to have_content 'Вход в систему выполнен с учётной записью из Twitter.'
  end
end
