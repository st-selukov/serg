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

  def current_votable_path(votable)
    if votable == 'question'
      visit question_path(parent)
    elsif votable == 'answer'
      visit question_path(parent.question)
    end
  end

  def vote_click_up(votable)
    if votable == 'question'
      within '.question_votes-wrapper' do
        find('.vote-up-link').click
      end
    elsif votable == 'answer'
      within '.single-question-answers__current-answer-wrapper_for-arrtibutes' do
        find('.vote-up-link').click
      end
    end
  end

  def vote_click_down(votable)
    if votable == 'question'
      within '.question_votes-wrapper' do
        find('.vote-down-link').click
      end
    elsif votable == 'answer'
      within '.single-question-answers__current-answer-wrapper_for-arrtibutes' do
        find('.vote-down-link').click
      end
    end
  end

  def vote_click_reset(votable)
    if votable == 'question'
      within '.question_votes-wrapper' do
        find('.vote-reset-link').click
      end
    elsif votable == 'answer'
      within '.single-question-answers__current-answer-wrapper_for-arrtibutes' do
        find('.vote-reset-link').click
      end
    end
  end
end
