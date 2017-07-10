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

  def create_valid_question
    visit questions_path
    within('.ask-question') do
      click_on 'Задать вопрос'
    end

    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[body]', with: 'Test Text'
    click_on 'Разместить вопрос на сайте'
  end

  def create_valid_answer(question)
    sign_in(user)
    visit question_path(question)
    fill_in  'answer[body]', with: 'Test Answer'
    click_on 'Разместить ответ'
  end

  def create_valid_question_comment(question)
    sign_in(user)
    visit question_path(question)
    find('.open-comments').click
    fill_in 'comment[body]', with: 'Test Comment'
    find('.add-new-comment-button').click
  end

  def create_valid_answer_comment(question)
    sign_in(user)
    visit question_path(question)
    within '.single-question-answers__current_answer' do
      find('.open-comments').click
    end
    fill_in 'comment[body]', with: 'Test Comment'
    find('.add-new-comment-button').click
  end

  def create_invalid_question_comment(question)
    sign_in(user)
    visit question_path(question)
    find('.open-comments').click
    fill_in 'comment[body]', with: ''
    find('.add-new-comment-button').click
  end

  def create_invalid_answer_comment(question)
    sign_in(user)
    visit question_path(question)
    within '.single-question-answers__current_answer' do
      find('.open-comments').click
    end
    fill_in 'comment[body]', with: ''
    find('.add-new-comment-button').click
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

  def mock_facebook
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '12345',
        info: {email: 'test@test.com'}
    )
  end

  def mock_twitter
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        provider: 'twitter',
        uid: '134567'
    )
  end
end
