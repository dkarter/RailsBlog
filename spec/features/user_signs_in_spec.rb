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
    pending('one at a time')
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    3.times do
      visit login_path
      fill_in 'Username', with: 'test@example.com'
      fill_in 'Password', with: 'password'
      click_on 'Login'
      expect(page).to have_content 'Invalid credentials'
    end

    visit login_path
    fill_in 'Username', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Login'
    expect(page).to have_content 'Too many sign in attemps. Account locked out.'
  end
end
