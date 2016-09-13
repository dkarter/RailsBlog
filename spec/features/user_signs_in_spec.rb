require 'rails_helper'

feature 'User signs in' do
  scenario 'with correct username and password' do
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    login_page = Pages::Login.new
    login_page.visit_page
    login_page.fill_and_submit(email: 'test@example.com', password: 'password')

    expect(login_page).to have_success_message
  end

  scenario 'with wrong password is shown a message' do
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    login_page = Pages::Login.new
    login_page.visit_page
    login_page.fill_and_submit(email: 'test@example.com', password: 'invalid')

    expect(login_page).to have_invalid_credentials_message
  end

  scenario 'with wrong username is shown a message' do
    FactoryGirl.create(:user, email: 'test@example.com', password: 'password')

    login_page = Pages::Login.new
    login_page.visit_page
    login_page.fill_and_submit(email: 'test1@example.com', password: 'password')

    expect(login_page).to have_invalid_credentials_message
  end

  scenario 'with bad credentials 3 times gets locked out' do
    user = FactoryGirl.create(:user, email: 'test1@example.com', password: 'password')

    login_page = Pages::Login.new

    4.times do
      login_page.visit_page
      login_page.fill_and_submit(email: 'test1@example.com', password: 'xyz')
    end

    expect(user.reload).to be_locked_out
    expect(login_page).to have_locked_out_message
  end
end
