require 'rails_helper'

feature 'User can sign in and sign out' do
  background do
    Fabricate(
      :user,
      full_name: 'Antoine Leclercq',
      email: 'antoine@example.com',
      password: 'password'
    )
  end

  scenario 'user signs in with valid credentials and and signs out' do
    visit sign_in_path

    sign_in

    expect_user_to_be_signed_in

    sign_out

    expect_user_to_be_signed_out
  end

  scenario 'user signs in with invalid credentials' do
    visit sign_in_path

    sign_in_with_invalid_credentials

    expect_error_to_be_displayed
  end

  def sign_in
    fill_in 'Email', with: 'antoine@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
  end

  def expect_user_to_be_signed_in
    expect(page).to have_content('signed in')
    expect(page).to have_content('Antoine Leclercq')
    expect(page).not_to have_content('Sign In')
    expect(page).not_to have_content('Sign Up')
  end

  def sign_out
    click_on 'Antoine Leclercq'
    click_on 'Sign Out'
  end

  def expect_user_to_be_signed_out
    expect(page).to have_content('signed out')
    expect(page).to have_content('Sign In')
  end

  def sign_in_with_invalid_credentials
    fill_in 'Email', with: 'antoine@example.com'
    fill_in 'Password', with: 'invalid password'
    click_button 'Sign In'
  end

  def expect_error_to_be_displayed
    expect(page).to have_content('Email or Password is invalid')
  end
end
