require_relative '../features_helper'

feature 'Add files to question' do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'user adds a file when he asks a question' do

    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[body]', with: 'Test Text'
    attach_file 'question_attachments_attributes_0_file', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Разместить вопрос на сайте'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'user ads also some file when ask question', js: true do

    fill_in 'question[title]', with: 'Test question'
    fill_in 'question[body]', with: 'Test Text'

    find('.attacment-nested-fields input').set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Добавить файл'
    find('.additional-attacments input').set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Разместить вопрос на сайте'

    expect(page).to have_content 'spec_helper.rb'
    expect(page).to have_content 'rails_helper.rb'
  end
end