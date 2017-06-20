shared_examples_for 'UserVoted' do

  before :each do
    @votable = parent.class.name.downcase
  end

  context 'with authenticated user' do
    scenario "user tries to vote for the #{@votable} for the first time", js: true do
      sign_in(user)
      current_votable_path(@votable)
      find(".vote-up-#{@votable}").click

      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '1'
    end

    scenario "user tries again to vote #{@votable}", js: true do
      sign_in(user)
      current_votable_path(@votable)
      find(".vote-up-#{@votable}").click

      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '1'
      find(".vote-up-#{@votable}").click
      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '1'
    end

    scenario "user tries delete his vote for #{@votable}", js: true do
      sign_in(user)
      current_votable_path(@votable)
      find(".vote-up-#{@votable}").click

      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '1'
      find(".vote-reset-#{@votable}").click
      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '0'
    end

    scenario "user tries to vote against for the #{@votable} first time", js: true do
      sign_in(user)
      current_votable_path(@votable)
      find(".vote-down-#{@votable}").click

      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '-1'
    end
  end

  context 'with unauthenticated user' do
    scenario 'host tries to vote for the answer ', js: true do
      current_votable_path(@votable)
      find(".vote-down-#{@votable}").click

      expect(page).to have_selector "##{@votable}-#{parent.id}-count-votes", text: '0'
    end
  end
end
