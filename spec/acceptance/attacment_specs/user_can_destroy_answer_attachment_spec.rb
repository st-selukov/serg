require_relative '../features_helper'

feature 'destroy answer attachment' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  scenario 'User can delete attachment of his answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Удалить файл'
    visit current_path

    expect(page).to_not have_content 'rails_helper.rb'
  end

  scenario 'The user can not delete attachment other than his own answer', js: true do
    sign_in(user2)

    expect(page).to_not have_content 'Удалить файл'
  end
end
