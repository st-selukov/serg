require_relative '../features_helper'

feature 'Add attachment to answer' do
  include_context 'users'
  given(:question) { create(:question, user_id: user.id) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'user ads file when write answer', js: true do

    fill_in 'answer[body]', with: 'Test Answer'
    find('.attacment-nested-fields input').set("#{Rails.root}/spec/models/user_spec.rb")
    click_on 'Разместить ответ'

    within '.single-question-attached-files-list' do
      expect(page).to have_content 'user_spec.rb'
    end
  end

  scenario 'user ad more some file when write answer', js: true do

    fill_in 'answer[body]', with: 'Test Answer'
    find('.attacment-nested-fields input').set("#{Rails.root}/spec/models/user_spec.rb")
    click_on 'Добавить файл'
    find('.additional-attacments input').set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Разместить ответ'

    within '.single-question-attached-files-list' do
      expect(page).to have_content 'user_spec.rb'
      expect(page).to have_content 'rails_helper.rb'
    end
  end
end
