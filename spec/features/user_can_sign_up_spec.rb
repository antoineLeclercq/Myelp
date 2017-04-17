require 'rails_helper'

feature 'User signs up' do
  scenario 'user signs up with valid information' do
    visit sign_up_path

    user_creates_account

    expect_user_to_be_redirected_to_sign_in_page
  end

  scenario 'user signs up with invalid information' do
    visit sign_up_path

    user_creates_account_with_invalid_info

    expect_error_to_be_displayed
  end

  def user_creates_account
    fill_in 'Full Name', with: 'Antoine Leclercq'
    fill_in 'City', with: 'New York'
    fill_in 'State', with: 'NY'
    fill_in 'Email', with: 'antoine@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'
  end

  def expect_user_to_be_redirected_to_sign_in_page
    expect(current_path).to eq(sign_in_path)
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
  end

  def user_creates_account_with_invalid_info
    fill_in 'Full Name', with: 'Antoine Leclercq'
    fill_in 'City', with: 'New York'
    fill_in 'State', with: 'NY'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password'
    click_button 'Sign Up'
  end

  def expect_error_to_be_displayed
    expect(page).to have_content('errors')
    expect(page).to have_content("Email can't be blank")
  end
end
