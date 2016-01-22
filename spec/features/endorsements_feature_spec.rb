require 'rails_helper'

feature 'endorsing reviews' do

  before do
    sign_up
    create_restaurant(name: 'Ledbury')
    review_restaurant('Ledbury',5)
  end

  scenario 'a user can endorese a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

end
