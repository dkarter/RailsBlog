require 'rails_helper'

feature 'User signs in' do
  scenario 'with correct username and password' do
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    visit login_path
    fill_in 'Username', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Login'
    expect(page).to have_content 'Success'
  end

  scenario 'with wrong password is shown a message'
  scenario 'with wrong username is shown a message'
  scenario 'with bad credentials 3 times gets locked out'
end
