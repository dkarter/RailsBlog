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

  scenario 'with wrong password is shown a message' do
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    visit login_path
    fill_in 'Username', with: 'test@example.com'
    fill_in 'Password', with: 'xyz'
    click_on 'Login'

    expect(page).to have_content 'Invalid credentials'
  end

  scenario 'with wrong username is shown a message' do
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    visit login_path
    fill_in 'Username', with: 'x@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Login'

    expect(page).to have_content 'Invalid credentials'
  end

  scenario 'with bad credentials 3 times gets locked out' do
    user = FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    4.times do
      visit login_path
      fill_in 'Username', with: 'test@example.com'
      fill_in 'Password', with: 'notmypassword'
      click_on 'Login'
    end

    expect(user.reload).to be_locked_out

    expect(page).to have_content 'Account locked out. Please try again later.'
  end
end
