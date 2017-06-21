require_relative '../features_helper'

feature 'destroy question attachment' do
  include_context 'users'
  given!(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }


  scenario 'User can delete attachment of his question', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Удалить файл'
    visit current_path

    expect(page).to_not have_content 'spec_helper.rb'
  end

  scenario 'The user can not delete attachment other than his own answer', js: true do
    sign_in(user2)

    expect(page).to_not have_content 'Удалить файл'
  end
end
